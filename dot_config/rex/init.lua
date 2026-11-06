rex.bind("cmd+s", "pane.send_key", { key = "ctrl+s" }) -- nvim 保存
rex.bind("cmd+o", "pane.send_key", { key = "ctrl+o" })

-- https://github.com/rawnly/smart-splits-backend-rex#rex-key-bindings
local function is_vim(ctx)
	local proc = rex.block.call("com.superlogical.terminal", "process", { block_id = ctx.block_id })
	local fg = proc and proc.foreground
	if not fg then
		return false
	end
	-- `name` is not always the executable's name, so check `argv0` too
	for _, s in ipairs({ fg.name or "", (fg.argv0 or ""):match("[^/]*$") }) do
		if s:match("^n?vim") then
			return true
		end
	end
	return false
end

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
	rex.bind("ctrl+" .. key, function(ctx)
		if is_vim(ctx) then
			return false
		end
		rex.session.focus_direction({ direction = direction })
		return true
	end)
end

local ENABLE = false

local SHELL = "com.superlogical.terminal.shell"

-- 块定义字段：
--   label     窗格标签（之后可用 -b label 定位）
--   cwd       工作目录（建议写展开后的绝对路径）
--   command   要运行的命令，省略则开交互 shell
--   keep_open 命令结束后窗格保留（看输出用）
--   split     第二块起的方向："right"(默认) / "below"
--   ratio     新块占分屏的比例 0~1
local workspaces = {
	["api"] = {
		windows = {
			{
				name = "编辑",
				blocks = {
					{ label = "editor", cwd = "/Users/ly/src/api", command = { "nvim" } },
					{
						label = "server",
						split = "right",
						ratio = 0.4,
						command = { "sh", "-c", "make watch" },
						keep_open = true,
					},
				},
			},
			{
				name = "日志",
				blocks = {
					{
						label = "logs",
						cwd = "/Users/ly/src/api",
						command = { "sh", "-c", "tail -f app.log" },
						keep_open = true,
					},
				},
			},
		},
	},
	-- 演示用：随时删除
	["demo"] = {
		windows = {
			{
				name = "trace-demo",
				blocks = {
					{ label = "agent" },
					{
						label = "trace",
						split = "right",
						ratio = 0.35,
						command = { "sh", "-c", "echo 这是右侧 trace 面板" },
						keep_open = true,
					},
				},
			},
		},
	},
}

local function block_of(def, win)
	local opts = {}
	opts.cwd = def.cwd or win.cwd
	if def.command then
		opts.command = def.command
	end
	if def.keep_open then
		opts.exit = { on_completion = false }
	end
	return rex.layout.block({ flavor = SHELL, options = opts })
end

-- 把 blocks 列表折叠成嵌套布局：第 1 块为根，后续块依次向右/向下分屏
local function build_layout(win)
	local layout = block_of(win.blocks[1], win)
	for i = 2, #win.blocks do
		local def = win.blocks[i]
		local node = block_of(def, win)
		local share = 1 - (def.ratio or 0.5) -- ratio 给新块，剩余留给已有布局
		if def.split == "below" then
			layout = rex.layout.vertical(share, layout, node)
		else
			layout = rex.layout.horizontal(share, layout, node)
		end
	end
	return layout
end

if ENABLE then
	-- 在新会话中打开工作区（会话常驻服务器，关掉窗口也不丢）
	rex.action({
		name = "workspace_open",
		title = "打开工作区",
		description = "按预定义布局新建一个会话。rex do workspace_open name=api",
		category = "工作区",
		args = { name = "string", focus = "boolean?" },
		run = function(ctx, args)
			local ws = workspaces[args.name]
			if ws == nil then
				local names = {}
				for k in pairs(workspaces) do
					names[#names + 1] = k
				end
				error("没有这个工作区: " .. args.name .. "（可选: " .. table.concat(names, ", ") .. "）", 0)
			end
			local windows = {}
			for _, win in ipairs(ws.windows) do
				windows[#windows + 1] = { layout = build_layout(win), window_label = win.name }
			end
			local created, err = rex.call("session.create", {
				label = args.name,
				initial_windows = windows,
			})
			if err ~= nil then
				error(err, 0)
			end
			-- 显式贴标签（layout 节点的 label 不一定被服务端采用）
			for wi, win in ipairs(ws.windows) do
				local ids = (created.initial_windows[wi] or {}).block_ids or {}
				for j, def in ipairs(win.blocks) do
					if def.label and ids[j] then
						rex.session.set_block_label({
							session_id = created.session_id,
							block_id = ids[j],
							label = def.label,
						})
					end
				end
			end
			if args.focus ~= false then
				-- 让 App 跳到新会话；App 没开也不报错
				pcall(function()
					rex.client.queue("session.select", { session_id = created.session_id })
				end)
			end
			return { session_id = created.session_id }
		end,
	})

	-- 把工作区的窗口叠加到当前会话（在"这里"载入布局）
	rex.action({
		name = "workspace_here",
		title = "在当前会话载入工作区",
		category = "工作区",
		args = { name = "string" },
		run = function(ctx, args)
			local ws = workspaces[args.name]
			if ws == nil then
				error("没有这个工作区: " .. args.name, 0)
			end
			local first
			for _, win in ipairs(ws.windows) do
				local w, err = rex.session.new_window({
					layout = build_layout(win),
					window_label = win.name,
				})
				if err ~= nil then
					error(err, 0)
				end
				first = first or w.window_id
			end
			return { first_window_id = first }
		end,
	})

	-- agent 运行时：当前（焦点）窗格跑 agent，右侧开 trace 面板
	rex.action({
		name = "agent_trace",
		title = "Agent 运行时布局",
		description = "当前窗格跑 agent，右侧新开 trace 面板窗格",
		category = "工作区",
		args = { trace_cmd = "string?" },
		run = function(ctx, args)
			local right = rex.layout.block({
				flavor = SHELL,
				options = {
					command = { "sh", "-c", args.trace_cmd or "exec $SHELL" },
					exit = { on_completion = false },
				},
			})
			-- 省略 anchor_id 即锚定焦点窗格；ratio 0~1 是锚点侧份额，新面板拿 38%
			local w, err = rex.session.new_split({
				direction = "horizontal",
				side = "after",
				ratio = 0.62,
				layout = right,
			})
			if err ~= nil then
				error(err, 0)
			end
			return { trace_block_id = w.block_ids[1] }
		end,
	})
end


-- >>> md-viewer: Cmd-F binding (managed by md-viewer setup; edits are replaced) >>>
local function md_viewer_pane(block)
  if block == nil then return false end
  local terminal = "com.superlogical.terminal"
  local process = rex.block.call(terminal, "process", { block_id = block })
  if process ~= nil then
    return process.foreground ~= nil and process.foreground.name == "md-viewer"
  end
  local listed = rex.session.list_blocks{}
  for _, entry in ipairs((listed or {}).blocks or {}) do
    if entry.block_id == block then return entry.label == "md-viewer" end
  end
  return false
end

rex.action{
  name = "md_viewer_find",
  title = "Find (md-viewer aware)",
  description = "Opens md-viewer's find in an md-viewer pane and Rex's Find everywhere else.",
  run = function(ctx, args)
    if md_viewer_pane(ctx.block_id) then
      local _, err = rex.block.call(
        "com.superlogical.terminal", "write", { block_id = ctx.block_id, data = "\27[102;9u" })
      if err == nil then return { target = "md-viewer" } end
    end
    rex.client.queue("client.find.open")
    return { target = "rex" }
  end,
}

rex.bind("cmd+f", "md_viewer_find")
-- <<< md-viewer <<<

-- >>> rexmod (managed by install.sh; edits inside are replaced)
-- Cmd+P: fuzzy file picker over the repo this tab's Claude works in.
rex.bind("cmd+p", function(ctx)
  rex.call("session.new_layer", {
    session_id = ctx.session_id,
    bounds = { 0.15, 0.1, 0.7, 0.75 },
    focus = true,
    layout = { block = { flavor = "com.superlogical.terminal.shell", label = "files", options = {
      shell = "none",
      command = { "/Users/ly/Library/Application Support/rexmod/bin/rexmod", "pick", "--here", "--session", ctx.session_id },
    } } },
  })
  return true
end)
-- <<< rexmod

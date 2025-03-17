local callback = function(chat, args)
  local handle = io.popen("git ls-files")
  if handle ~= nil then
    local result = handle:read("*a")
    handle:close()
    chat:add_reference({ content = result }, "git", "<git_files>")
  else
    return vim.notify("No git files available", vim.log.levels.INFO, { title = "CodeCompanion" })
  end
end

return {
  description = "List git files",
  callback = callback,
  opts = {
    contains_code = false,
  },
}

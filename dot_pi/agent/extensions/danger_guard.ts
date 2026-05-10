import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { isToolCallEventType } from "@mariozechner/pi-coding-agent";

interface DangerPattern {
	name: string;
	test: (cmd: string) => boolean;
	message: (cmd: string) => string;
}

const DANGER_PATTERNS: DangerPattern[] = [
	{
		name: "rm",
		test: (cmd) => /\brm\b/.test(cmd) && !/\brm\s+-i\b/.test(cmd),
		message: (cmd) => `检测到删除命令：\n  ${cmd}\n\n确认执行？`,
	},
	{
		name: "git-force-push",
		test: (cmd) => /\bgit\s+push\b/.test(cmd) && /(-f\b|--force)/.test(cmd),
		message: (cmd) =>
			`检测到强制推送：\n  ${cmd}\n\n强制推送会覆盖远程历史，确认执行？`,
	},
	{
		name: "git-reset-hard",
		test: (cmd) => /\bgit\s+reset\b/.test(cmd) && /--hard/.test(cmd),
		message: (cmd) =>
			`检测到硬重置：\n  ${cmd}\n\n未提交的更改将丢失，确认执行？`,
	},
	{
		name: "git-clean",
		test: (cmd) => /\bgit\s+clean\b/.test(cmd) && /(-f\b|--force)/.test(cmd),
		message: (cmd) =>
			`检测到强制清理：\n  ${cmd}\n\n未跟踪文件将被删除，确认执行？`,
	},
	{
		name: "dd",
		test: (cmd) => /^\s*dd\b/.test(cmd),
		message: (cmd) =>
			`检测到 dd 磁盘写入：\n  ${cmd}\n\n此操作可能破坏数据，确认执行？`,
	},
	{
		name: "mkfs",
		test: (cmd) => /\bmkfs\./.test(cmd) || /^\s*mkfs\b/.test(cmd),
		message: (cmd) =>
			`检测到格式化命令：\n  ${cmd}\n\n磁盘数据将被清除，确认执行？`,
	},
	{
		name: "chmod-root",
		test: (cmd) =>
			/\bchmod\b/.test(cmd) &&
			/\s+(-R\b|-r\b|--recursive)/.test(cmd) &&
			/\s+777/.test(cmd) &&
			/\/(\s|$)/.test(cmd),
		message: (cmd) =>
			`检测到危险权限修改：\n  ${cmd}\n\n将递归修改根目录权限为 777，确认执行？`,
	},
	{
		name: "curl-pipe-sh",
		test: (cmd) => /\bcurl\b/.test(cmd) && /\|\s*(sh|bash|zsh)\b/.test(cmd),
		message: (cmd) =>
			`检测到远程脚本直接执行：\n  ${cmd}\n\n管道执行远程脚本存在安全风险，确认执行？`,
	},
	{
		name: "sudo-danger",
		test: (cmd) =>
			/\bsudo\b/.test(cmd) && /\b(rm\b|dd\b|mkfs|fdisk|parted)\b/.test(cmd),
		message: (cmd) =>
			`检测到 sudo 高危命令：\n  ${cmd}\n\n以 root 身份执行危险操作，确认执行？`,
	},
];

function findDangerPatterns(cmd: string): DangerPattern[] {
	return DANGER_PATTERNS.filter((p) => p.test(cmd));
}

export default function dangerGuard(pi: ExtensionAPI) {
	pi.on("tool_call", async (event, ctx) => {
		if (!isToolCallEventType("bash", event)) return;

		const cmd = event.input.command;
		if (!cmd) return;

		const dangers = findDangerPatterns(cmd);
		if (dangers.length === 0) return;

		// 拼接所有命中规则的消息
		const messages = dangers.map((d) => d.message(cmd)).join("\n\n");
		const title =
			dangers.length > 1
				? `检测到 ${dangers.length} 个危险操作`
				: `检测到危险命令`;

		const ok = await ctx.ui.confirm(title, messages);
		if (!ok) {
			return {
				block: true,
				reason: `用户拒绝了危险命令: ${dangers.map((d) => d.name).join(", ")}`,
			};
		}
	});
}

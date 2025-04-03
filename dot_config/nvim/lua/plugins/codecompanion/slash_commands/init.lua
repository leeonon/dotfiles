-- 来自yingmanwumen https://github.com/yingmanwumen/nvim/blob/a09f03a/lua/plugins/ai/codecompanion/slash_commands/init.lua
return {
  ["dump_session"] = require("plugins.codecompanion.slash_commands.dump_session"),
  ["restore_session"] = require("plugins.codecompanion.slash_commands.restore_session"),
  ["delete_session"] = require("plugins.codecompanion.slash_commands.delete_session"),
  ["git_files"] = require("plugins.codecompanion.slash_commands.git_file"),
  ["git_commit"] = require("plugins.codecompanion.slash_commands.git_commit"),
  ["git_diff"] = require("plugins.codecompanion.slash_commands.review_git_diff"),
}

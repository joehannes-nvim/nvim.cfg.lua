-- [nfnl] Compiled from fnl/plugins/config/xbase.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  return (require("xbase")).setup({log_buffer = {default_direction = "horizontal", focus = true, height = 20, width = 75}, log_level = vim.log.levels.DEBUG, mappings = {all_picker = "<leader>x<cr>!", build_picker = "<leader>x<cr>b", enable = true, run_picker = "<leader>x<cr>r", toggle_split_log_buffer = "<leader>tlxs", toggle_vsplit_log_buffer = "<leader>tlxv", watch_picker = "<leader>x<cr>w"}, simctl = {iOS = {}, tvOS = {}, watchOS = {}}, sourcekit = {}, statusline = {device_running = {color = "#4a6edb", icon = "\239\148\180"}, failure = {color = "#db4b4b", icon = "\239\153\153"}, success = {color = "#1abc9c", icon = "\239\133\138"}, watching = {color = "#1abc9c", icon = "\239\145\129"}}})
end
return M

-- [nfnl] Compiled from fnl/plugins/config/noice.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  return (require("noice")).setup({lsp = {override = {["cmp.entry.get_documentation"] = true}, ["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true}, messages = {view = "notify", view_error = "notify", view_history = "messages", view_search = "virtualtext", view_warn = "notify", enabled = false}, presets = {bottom_search = true, command_palette = true, inc_rename = true, long_message_to_split = true, lsp_doc_border = true}})
end
return M

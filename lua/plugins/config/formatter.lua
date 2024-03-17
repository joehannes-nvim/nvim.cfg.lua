-- [nfnl] Compiled from fnl/plugins/config/formatter.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local defaults = require("formatter.defaults")
local util = require("formatter.util")
M.setup = function()
  local function stylua()
    return {args = {vim.api.nvim_buf_get_name(0)}, exe = "stylua", stdin = false}
  end
  local ts = require("formatter.filetypes.typescript")
  local tsx = require("formatter.filetypes.typescriptreact")
  return (require("formatter")).setup({filetype = {javascript = require("formatter.filetypes.javascript"), javascriptreact = require("formatter.filetypes.javascriptreact"), lua = {stylua}, typescript = ts, typescriptreact = {tsx.prettierd, tsx.prettiereslint, tsx.eslint_d, tsx.prettier}}})
end
return M

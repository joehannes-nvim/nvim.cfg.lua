-- [nfnl] Compiled from fnl/keymappings/insert.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {{"<C-Del>", "<cmd>lua require(\"notify\").dismiss()<cr>"}, {"<C-h>", "<C-o>B"}, {"<C-l>", "<C-o>W"}, {"<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>"}}
return M

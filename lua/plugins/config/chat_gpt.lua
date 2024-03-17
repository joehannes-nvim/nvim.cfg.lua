-- [nfnl] Compiled from fnl/plugins/config/chat_gpt.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local home = vim.fn.expand("$HOME")
M.setup = function()
  return (require("chatgpt")).setup({api_key_cmd = ("cat " .. home .. "/.local/git/joehannes-os/safe/chatgpt.txt")})
end
return M

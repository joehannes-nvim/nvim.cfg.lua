-- [nfnl] Compiled from fnl/lang/init.fnl by https://github.com/Olical/nfnl, do not edit.
local lspconfig = require("lspconfig")
do end (require("mason")).setup()
do end (require("mason-lspconfig")).setup({automatic_installation = true})
local cfg = require("lang/setup")
local my_servers = {clojure = "clojure_lsp", fennel = "fennel_language_server", css = "cssls", cssmodules = "cssmodules_ls", efm = "efm", graphql = "graphql", html = "html", json = "jsonls", lua = "lua_ls", python = "pyright", rust = "rust_analyzer", sourcekit = "sourcekit", tailwind = "tailwindcss", typescript = "tsserver"}
vim.fn.sign_define("LspDiagnosticsSignError", {numhl = "LspDiagnosticsDefaultError", text = "\226\156\152"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {numhl = "LspDiagnosticsDefaultWarning", text = "\239\129\177"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {numhl = "LspDiagnosticsDefaultInformation", text = "\239\132\169"})
vim.fn.sign_define("LspDiagnosticsSignHint", {numhl = "LspDiagnosticsDefaultHint", text = "\239\129\156"})
vim.fn.sign_define("DiagnosticSignError", {numhl = "LspDiagnosticsDefaultError", text = "\226\156\152"})
vim.fn.sign_define("DiagnosticSignWarn", {numhl = "LspDiagnosticsDefaultWarning", text = "\239\129\177"})
vim.fn.sign_define("DiagnosticSignInfo", {numhl = "LspDiagnosticsDefaultInformation", text = "\239\132\169"})
vim.fn.sign_define("DiagnosticSignHint", {numhl = "LspDiagnosticsDefaultHint", text = "\239\129\156"})
for server, name in pairs(my_servers) do
  if (server == "fennel") then
    cfg[server]()
    lspconfig[name].setup({})
  else
  end
  local _2_
  do
    local truthy = false
    for _, s in ipairs({"json", "css", "cssmodules", "lua", "python", "clojure", "efm"}) do
      truthy = (truthy or (server == s))
    end
    _2_ = truthy
  end
  if _2_ then
    lspconfig[name].setup(cfg[server]())
  elseif (server == "typescript") then
    do end (require("typescript")).setup({server = cfg[server](), debug = false, disable_commands = false})
  else
    lspconfig[name].setup(cfg.generic())
  end
end
return vim.cmd("do User LspAttachBuffers")

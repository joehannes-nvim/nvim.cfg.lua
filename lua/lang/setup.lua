-- [nfnl] Compiled from fnl/lang/setup.fnl by https://github.com/Olical/nfnl, do not edit.
local root_pattern = (require("lspconfig.util")).root_pattern
local on_attach = require("lang/attach")
local capabilities = require("lang/capabilities")
local lspconfig = require("lspconfig")
local setup = {}
local sumneko_root_path = (vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server/bin")
local sumneko_binary = (sumneko_root_path .. "/lua-language-server")
setup.generic = function()
  local opts = {capabilities = capabilities, on_attach = on_attach.generic}
  return opts
end
setup.diagnostic = function()
  local opts = {capabilities = capabilities, filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"}, init_options = {filetypes = {javascript = "eslint", javascriptreact = "eslint", typescript = "eslint", typescriptreact = "eslint"}, linters = {eslint = {args = {"--cache", "--stdin", "--stdin-filename", "%filepath", "--format", "json"}, command = "eslint_d", debounce = 100, parseJson = {column = "column", endColumn = "endColumn", endLine = "endLine", errorsRoot = "[0].messages", line = "line", message = "${message} [${ruleId}]", security = "severity"}, rootPatterns = {".eslintrc.js", ".eslintrc.json", ".eslintrc", "package.json"}, securities = {"warning", "error"}, sourceName = "eslint"}}}, on_attach = on_attach.minimal}
  return opts
end
setup.eslint = function()
  local opts = {capabilities = capabilities, on_attach = on_attach.minimal, settings = {format = {enable = false}}}
  return opts
end
setup.json = function()
  local opts = {capabilities = capabilities, on_attach = on_attach.generic, settings = {json = {schemas = {{fileMatch = {"package.json"}, url = "https://json.schemastore.org/package.json"}, {fileMatch = {"tsconfig*.json"}, url = "https://json.schemastore.org/tsconfig.json"}, {fileMatch = {".prettierrc", ".prettierrc.json", "prettier.config.json"}, url = "https://json.schemastore.org/prettierrc.json"}, {fileMatch = {".eslintrc", ".eslintrc.json"}, url = "https://json.schemastore.org/eslintrc.json"}, {fileMatch = {".babelrc", ".babelrc.json", "babel.config.json"}, url = "https://json.schemastore.org/babelrc.json"}, {fileMatch = {"lerna.json"}, url = "https://json.schemastore.org/lerna.json"}, {fileMatch = {"now.json", "vercel.json"}, url = "https://json.schemastore.org/now.json"}, {fileMatch = {"ecosystem.json"}, url = "https://json.schemastore.org/pm2-ecosystem.json"}}}}}
  return opts
end
setup.typescript = function()
  local opts = {capabilities = capabilities, handlers = {["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})}, on_attach = on_attach.typescript, settings = {filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"}, format = {enable = true}}}
  return opts
end
setup.clojure = function()
  local opts = {capabilities = capabilities, handlers = {["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})}, on_attach = on_attach.clojure, settings = {filetypes = {"clojure", "clojurescript", "clojuredart", "cljd", "cljs", "edn"}, format = {enable = true}}}
  return opts
end
setup.fennel = function()
  require("lspconfig.configs")["fennel_language_server"] = {default_config = {cmd = {"/home/joehannes/.cargo/bin/fennel-language-server"}, filetypes = {"fennel"}, single_file_support = true, root_dir = lspconfig.util.root_pattern("fnl"), settings = {fennel = {workspace = {library = vim.api.nvim_list_runtime_paths()}, diagnostics = {globals = {"set-forcibly!", "vim", unpack(vim.tbl_keys(_G))}}}}}}
  return nil
end
setup.dart = function()
  local opts = {capabilities = capabilities, handlers = {["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})}, on_attach = on_attach.generic, settings = {format = {enable = true}}, server = {dartls = {cmd = {"dart", "language-server", "--protocol=lsp"}}}}
  return opts
end
setup.rust_analyzer = function()
  local opts = {capabilities = capabilities, handlers = {["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})}, on_attach = on_attach.generic, settings = {format = {enable = true}}}
  return opts
end
setup.python = function()
  local opts = {capabilities = capabilities, handlers = {["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}), ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded"})}, on_attach = on_attach.python, settings = {format = {enable = true}, pyright = {analysis = {autoImportCompletions = true, autoSearchPaths = true, diagnosticMode = "workspace", useLibraryCodeForTypes = true}, disableOrganizeImports = false}}}
  return opts
end
setup.lua = function()
  local opts
  local function _1_(client, bufnr)
    on_attach.lua(client, bufnr)
    return (require("lsp-format")).on_attach(client)
  end
  opts = {capabilities = capabilities, cmd = {sumneko_binary, "-E", (sumneko_root_path .. "/main.lua")}, on_attach = _1_, settings = {Lua = {completion = {callSnippet = "Replace"}, diagnostics = {globals = {"vim"}}, runtime = {path = vim.split(package.path, ";"), version = "LuaJIT"}, workspace = {library = {}, checkThirdParty = false}}, format = {enable = true}}}
  return opts
end
setup.css = function()
  local opts = {capabilities = capabilities, on_attach = on_attach.minimal, settings = {cmd = {"vscode-css-language-server", "--stdio"}, css = {lint = {unknownAtRules = "ignore"}, validate = true}, filetypes = {"css", "scss", "less"}, less = {lint = {unknownAtRules = "ignore"}, validate = true}, scss = {lint = {unknownAtRules = "ignore"}, validate = true}}}
  return opts
end
setup.cssmodules = function()
  local opts = {capabilities = capabilities, on_attach = on_attach.minimal, settings = {cmd = {"cssmodules-language-server"}, filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"}}}
  return opts
end
setup.efm = function()
  local efmls = require("efmls-configs")
  local efm_fs = require("efmls-configs.fs")
  local root_path = vim.api.nvim_call_function("getcwd", {})
  local eslint_cfg_path
  local function _2_(_, value)
    return ((my.fs.exists((root_path .. "/" .. value)) and (root_path .. "/" .. value)) or nil)
  end
  eslint_cfg_path = (table.foreach({".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json"}, _2_) or (root_path .. "/package.json"))
  local prettier_cfg_path
  local function _3_(_, value)
    return ((my.fs.exists((root_path .. "/" .. value)) and (root_path .. "/" .. value)) or nil)
  end
  prettier_cfg_path = (table.foreach({".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml", ".prettierrc.json5", ".prettierrc.js", ".prettierrc.cjs", ".prettierrc.config.js", ".prettierrc.config.cjs", ".prettierrc.toml"}, _3_) or (root_path .. "/package.json"))
  local stylelint = require("efmls-configs.linters.stylelint")
  local eslint = require("efmls-configs.linters.eslint_d")
  local prettier_default = require("efmls-configs.formatters.prettier")
  local prettier = {formatCommand = string.format(("%s --stdin --stdin-filepath ${INPUT}" .. " --eslint-config-path " .. eslint_cfg_path .. " --config " .. prettier_cfg_path), efm_fs.executable("prettier-eslint", efm_fs.Scope.NODE)), formatStdin = true}
  local clj_kondo = require("plugins/config/clj_kondo")
  local joker = require("efmls-configs.formatters.joker")
  local handlers = {["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {signs = true, underline = true, virutal_text = true, update_in_insert = false})}
  local init_opts = {handlers = handlers, init_options = {documentFormatting = true, documentRangeFormatting = true}, on_attach = on_attach.minimal}
  local languages = {css = {formatter = prettier_default, linter = stylelint}, javascript = {formatter = prettier, linter = eslint}, javascriptreact = {formatter = prettier, linter = eslint}, scss = {formatter = prettier_default, linter = stylelint}, typescript = {formatter = prettier, linter = eslint}, typescriptreact = {formatter = prettier, linter = eslint}}
  return vim.tbl_deep_extend("force", init_opts, {filetypes = vim.tbl_keys(languages), settings = {languages = languages, rootMarkers = {".git/"}}})
end
setup.generic = function()
  local opts = {autostart = true, capabilities = capabilities, on_attach = on_attach.minimal, settings = {format = {enable = false}}}
  return opts
end
setup.null = function()
  local ls = require("null-ls")
  return ls.setup({on_attach = on_attach.null_ls, sources = {ls.builtins.diagnostics.eslint_d, ls.builtins.code_actions.eslint_d, ls.builtins.formatting.prettier}, update_in_insert = true})
end
return setup

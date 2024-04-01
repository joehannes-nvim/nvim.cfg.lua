-- [nfnl] Compiled from fnl/utils/astro/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local tbl_contains = vim.tbl_contains
local tbl_isempty = vim.tbl_isempty
local user_opts = _G.my.astro.user_opts
local utils = require("utils.astro")
local conditional_func = utils.conditional_func
local is_available = utils.is_available
local extend_tbl = utils.extend_tbl
local server_config = "lsp.config."
local setup_handlers
local function _1_(server, opts)
  return ((require("lspconfig"))[server]).setup(opts)
end
setup_handlers = user_opts("lsp.setup_handlers", {_1_})
M.diagnostics = {{}, {}, {}, [0] = {}}
local function _2_(signs)
  local default_diagnostics = _G.my.astro.user_opts("diagnostics", {float = {border = "rounded", header = "", prefix = "", source = "always", style = "minimal", focused = false}, severity_sort = true, signs = {active = signs}, underline = true, update_in_insert = true, virtual_text = true})
  M.diagnostics = {extend_tbl(default_diagnostics, {signs = false, virtual_text = false}), extend_tbl(default_diagnostics, {virtual_text = false}), default_diagnostics, [0] = extend_tbl(default_diagnostics, {signs = false, virtual_text = false, update_in_insert = false, underline = false})}
  return vim.diagnostic.config(M.diagnostics[vim.g.diagnostics_mode])
end
M.setup_diagnostics = _2_
M.formatting = user_opts("lsp.formatting", {disabled = {}, format_on_save = {enabled = true}})
if (type(M.formatting.format_on_save) == "boolean") then
  M.formatting.format_on_save = {enabled = M.formatting.format_on_save}
else
end
M.format_opts = vim.deepcopy(M.formatting)
M.format_opts.disabled = nil
M.format_opts.format_on_save = nil
local function _4_(client)
  local filter = M.formatting.filter
  local disabled = (M.formatting.disabled or {})
  return not (vim.tbl_contains(disabled, client.name) or ((type(filter) == "function") and not filter(client)))
end
M.format_opts.filter = _4_
local function _5_(server)
  local config_avail, config = pcall(require, ("lspconfig.server_configurations." .. server))
  if (not config_avail or not config.default_config) then
    local server_definition = user_opts((server_config .. server))
    if server_definition.cmd then
      require("lspconfig.configs")[server] = {default_config = server_definition}
    else
    end
  else
  end
  local opts = M.config(server)
  local setup_handler = (setup_handlers[server] or setup_handlers[1])
  if (not vim.tbl_contains(_G.my.astro.lsp.skip_setup, server) and setup_handler) then
    return setup_handler(server, opts)
  else
    return nil
  end
end
M.setup = _5_
M.has_capability = function(capability, filter)
  for _, client in ipairs(vim.lsp.get_active_clients(filter)) do
    if client.supports_method(capability) then
      return true
    else
    end
  end
  return false
end
local function add_buffer_autocmd(augroup, bufnr, autocmds)
  if not vim.tbl_islist(autocmds) then
    autocmds = {autocmds}
  else
  end
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, {buffer = bufnr, group = augroup})
  if (not cmds_found or vim.tbl_isempty(cmds)) then
    vim.api.nvim_create_augroup(augroup, {clear = false})
    for _, autocmd in ipairs(autocmds) do
      local events = autocmd.events
      autocmd.events = nil
      autocmd.group = augroup
      autocmd.buffer = bufnr
      vim.api.nvim_create_autocmd(events, autocmd)
    end
    return nil
  else
    return nil
  end
end
local function del_buffer_autocmd(augroup, bufnr)
  local cmds_found, cmds = pcall(vim.api.nvim_get_autocmds, {buffer = bufnr, group = augroup})
  if cmds_found then
    local function _12_(cmd)
      return vim.api.nvim_del_autocmd(cmd.id)
    end
    return vim.tbl_map(_12_, cmds)
  else
    return nil
  end
end
local function _14_(client, bufnr)
  local lsp_mappings = (require("utils.astro")).empty_map_table()
  local function _15_()
    return vim.diagnostic.open_float()
  end
  lsp_mappings.n["<leader>ld"] = {_15_, desc = "Hover diagnostics"}
  local function _16_()
    return vim.diagnostic.goto_prev()
  end
  lsp_mappings.n["[d"] = {_16_, desc = "Previous diagnostic"}
  local function _17_()
    return vim.diagnostic.goto_next()
  end
  lsp_mappings.n["]d"] = {_17_, desc = "Next diagnostic"}
  local function _18_()
    return vim.diagnostic.open_float()
  end
  lsp_mappings.n["gl"] = {_18_, desc = "Hover diagnostics"}
  if is_available("telescope.nvim") then
    local function _19_()
      return (require("telescope.builtin")).diagnostics()
    end
    lsp_mappings.n["<leader>lD"] = {_19_, desc = "Search diagnostics"}
  else
  end
  if is_available("mason-lspconfig.nvim") then
    lsp_mappings.n["<leader>li"] = {"<cmd>LspInfo<cr>", desc = "LSP information"}
  else
  end
  if is_available("null-ls.nvim") then
    lsp_mappings.n["<leader>lI"] = {"<cmd>NullLsInfo<cr>", desc = "Null-ls information"}
  else
  end
  if client.supports_method("textDocument/codeAction") then
    local function _23_()
      return vim.lsp.buf.code_action()
    end
    lsp_mappings.n["<leader>la"] = {_23_, desc = "LSP code action"}
    lsp_mappings.v["<leader>la"] = lsp_mappings.n["<leader>la"]
  else
  end
  if client.supports_method("textDocument/codeLens") then
    local function _25_()
      if not M.has_capability("textDocument/codeLens", {bufnr = bufnr}) then
        del_buffer_autocmd("lsp_codelens_refresh", bufnr)
        return 
      else
      end
      if vim.g.codelens_enabled then
        return vim.lsp.codelens.refresh()
      else
        return nil
      end
    end
    add_buffer_autocmd("lsp_codelens_refresh", bufnr, {callback = _25_, desc = "Refresh codelens", events = {"InsertLeave", "BufEnter"}})
    if vim.g.codelens_enabled then
      vim.lsp.codelens.refresh()
    else
    end
    local function _29_()
      return vim.lsp.codelens.refresh()
    end
    lsp_mappings.n["<leader>ll"] = {_29_, desc = "LSP CodeLens refresh"}
    local function _30_()
      return vim.lsp.codelens.run()
    end
    lsp_mappings.n["<leader>lL"] = {_30_, desc = "LSP CodeLens run"}
  else
  end
  if client.supports_method("textDocument/declaration") then
    local function _32_()
      return vim.lsp.buf.declaration()
    end
    lsp_mappings.n["gD"] = {_32_, desc = "Declaration of current symbol"}
  else
  end
  if client.supports_method("textDocument/definition") then
    local function _34_()
      return vim.lsp.buf.definition()
    end
    lsp_mappings.n["gd"] = {_34_, desc = "Show the definition of current symbol"}
  else
  end
  if (client.supports_method("textDocument/formatting") and not tbl_contains(M.formatting.disabled, client.name)) then
    local function _36_()
      return vim.lsp.buf.format(M.format_opts)
    end
    lsp_mappings.n["<leader>lf"] = {_36_, desc = "Format buffer"}
    lsp_mappings.v["<leader>lf"] = lsp_mappings.n["<leader>lf"]
    local function _37_()
      return vim.lsp.buf.format(M.format_opts)
    end
    vim.api.nvim_buf_create_user_command(bufnr, "Format", _37_, {desc = "Format file with LSP"})
    local autoformat = M.formatting.format_on_save
    local filetype = vim.api.nvim_get_option_value("filetype", {buf = bufnr})
    if ((autoformat.enabled and (tbl_isempty((autoformat.allow_filetypes or {})) or tbl_contains(autoformat.allow_filetypes, filetype))) and (tbl_isempty((autoformat.ignore_filetypes or {})) or not tbl_contains(autoformat.ignore_filetypes, filetype))) then
      local function _38_()
        if not M.has_capability("textDocument/formatting", {bufnr = bufnr}) then
          del_buffer_autocmd("lsp_auto_format", bufnr)
          return 
        else
        end
        local autoformat_enabled = vim.b.autoformat_enabled
        if (autoformat_enabled == nil) then
          autoformat_enabled = vim.g.autoformat_enabled
        else
        end
        if (autoformat_enabled and (not autoformat.filter or autoformat.filter(bufnr))) then
          return vim.lsp.buf.format(extend_tbl(M.format_opts, {bufnr = bufnr}))
        else
          return nil
        end
      end
      add_buffer_autocmd("lsp_auto_format", bufnr, {callback = _38_, desc = "autoformat on save", events = "BufWritePre"})
      local function _42_()
        return (require("utils.astro.ui")).toggle_buffer_autoformat()
      end
      lsp_mappings.n["<leader>uf"] = {_42_, desc = "Toggle autoformatting (buffer)"}
      local function _43_()
        return (require("utils.astro.ui")).toggle_autoformat()
      end
      lsp_mappings.n["<leader>uF"] = {_43_, desc = "Toggle autoformatting (global)"}
    else
    end
  else
  end
  if client.supports_method("textDocument/documentHighlight") then
    local function _46_()
      if not M.has_capability("textDocument/documentHighlight", {bufnr = bufnr}) then
        del_buffer_autocmd("lsp_document_highlight", bufnr)
        return 
      else
      end
      return vim.lsp.buf.document_highlight()
    end
    local function _48_()
      return vim.lsp.buf.clear_references()
    end
    add_buffer_autocmd("lsp_document_highlight", bufnr, {{callback = _46_, desc = "highlight references when cursor holds", events = {"CursorHold", "CursorHoldI"}}, {callback = _48_, desc = "clear references when cursor moves", events = {"CursorMoved", "CursorMovedI", "BufLeave"}}})
  else
  end
  if client.supports_method("textDocument/hover") then
    if (vim.fn.has("nvim-0.10") == 0) then
      local function _50_()
        return vim.lsp.buf.hover()
      end
      lsp_mappings.n["K"] = {_50_, desc = "Hover symbol details"}
    else
    end
  else
  end
  if client.supports_method("textDocument/implementation") then
    local function _53_()
      return vim.lsp.buf.implementation()
    end
    lsp_mappings.n["gI"] = {_53_, desc = "Implementation of current symbol"}
  else
  end
  if client.supports_method("textDocument/inlayHint") then
    if (vim.b.inlay_hints_enabled == nil) then
      vim.b.inlay_hints_enabled = vim.g.inlay_hints_enabled
    else
    end
    if vim.lsp.inlay_hint then
      if vim.b.inlay_hints_enabled then
        vim.lsp.inlay_hint.enable(bufnr, true)
      else
      end
      local function _57_()
        return (require("utils.astro.ui")).toggle_buffer_inlay_hints(bufnr)
      end
      lsp_mappings.n["<leader>uH"] = {_57_, desc = "Toggle LSP inlay hints (buffer)"}
    else
    end
  else
  end
  if client.supports_method("textDocument/references") then
    local function _60_()
      return vim.lsp.buf.references()
    end
    lsp_mappings.n["gr"] = {_60_, desc = "References of current symbol"}
    local function _61_()
      return vim.lsp.buf.references()
    end
    lsp_mappings.n["<leader>lR"] = {_61_, desc = "Search references"}
  else
  end
  if client.supports_method("textDocument/rename") then
    local function _63_()
      return vim.lsp.buf.rename()
    end
    lsp_mappings.n["<leader>lr"] = {_63_, desc = "Rename current symbol"}
  else
  end
  if client.supports_method("textDocument/signatureHelp") then
    local function _65_()
      return vim.lsp.buf.signature_help()
    end
    lsp_mappings.n["<leader>lh"] = {_65_, desc = "Signature help"}
  else
  end
  if client.supports_method("textDocument/typeDefinition") then
    local function _67_()
      return vim.lsp.buf.type_definition()
    end
    lsp_mappings.n["gy"] = {_67_, desc = "Definition of current type"}
  else
  end
  if client.supports_method("workspace/symbol") then
    local function _69_()
      return vim.lsp.buf.workspace_symbol()
    end
    lsp_mappings.n["<leader>lG"] = {_69_, desc = "Search workspace symbols"}
  else
  end
  if (client.supports_method("textDocument/semanticTokens/full") and vim.lsp.semantic_tokens) then
    if vim.g.semantic_tokens_enabled then
      vim.b[bufnr]["semantic_tokens_enabled"] = true
      local function _71_()
        return (require("utils.astro.ui")).toggle_buffer_semantic_tokens(bufnr)
      end
      lsp_mappings.n["<leader>uY"] = {_71_, desc = "Toggle LSP semantic highlight (buffer)"}
    else
      client.server_capabilities.semanticTokensProvider = nil
    end
  else
  end
  if is_available("telescope.nvim") then
    if lsp_mappings.n.gd then
      local function _74_()
        return (require("telescope.builtin")).lsp_definitions()
      end
      lsp_mappings.n.gd[1] = _74_
    else
    end
    if lsp_mappings.n.gI then
      local function _76_()
        return (require("telescope.builtin")).lsp_implementations()
      end
      lsp_mappings.n.gI[1] = _76_
    else
    end
    if lsp_mappings.n.gr then
      local function _78_()
        return (require("telescope.builtin")).lsp_references()
      end
      lsp_mappings.n.gr[1] = _78_
    else
    end
    if lsp_mappings.n["<leader>lR"] then
      local function _80_()
        return (require("telescope.builtin")).lsp_references()
      end
      lsp_mappings.n["<leader>lR"][1] = _80_
    else
    end
    if lsp_mappings.n.gy then
      local function _82_()
        return (require("telescope.builtin")).lsp_type_definitions()
      end
      lsp_mappings.n.gy[1] = _82_
    else
    end
    if lsp_mappings.n["<leader>lG"] then
      local function _84_()
        local function _85_(query)
          if query then
            if (query == "") then
              query = vim.fn.expand("<cword>")
            else
            end
            return (require("telescope.builtin")).lsp_workspace_symbols({prompt_title = ("Find word (%s)"):format(query)})
          else
            return nil
          end
        end
        return vim.ui.input({prompt = "Symbol Query: (leave empty for word under cursor)"}, _85_)
      end
      lsp_mappings.n["<leader>lG"][1] = _84_
    else
    end
  else
  end
  if not vim.tbl_isempty(lsp_mappings.v) then
    lsp_mappings.v["<leader>l"] = {desc = (utils.get_icon("ActiveLSP", 1, true) .. "LSP")}
  else
  end
  utils.set_mappings(user_opts("lsp.mappings", lsp_mappings), {buffer = bufnr})
  for id, _ in pairs(_G.my.astro.lsp.progress) do
    if not next(vim.lsp.get_active_clients({id = tonumber(id:match("^%d+"))})) then
      _G.my.astro.lsp.progress[id] = nil
    else
    end
  end
  local on_attach_override = user_opts("lsp.on_attach", nil, false)
  return conditional_func(on_attach_override, true, client, bufnr)
end
M.on_attach = _14_
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.documentationFormat = {"markdown", "plaintext"}
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = {valueSet = {1}}
M.capabilities.textDocument.completion.completionItem.resolveSupport = {properties = {"documentation", "detail", "additionalTextEdits"}}
M.capabilities.textDocument.foldingRange = {lineFoldingOnly = true, dynamicRegistration = false}
M.capabilities = user_opts("lsp.capabilities", M.capabilities)
M.flags = user_opts("lsp.flags")
M.config = function(server_name)
  local server = (require("lspconfig"))[server_name]
  local lsp_opts = extend_tbl(server, {capabilities = M.capabilities, flags = M.flags})
  if (server_name == "jsonls") then
    local schemastore_avail, schemastore = pcall(require, "schemastore")
    if schemastore_avail then
      lsp_opts.settings = {json = {schemas = schemastore.json.schemas(), validate = {enable = true}}}
    else
    end
  else
  end
  if (server_name == "yamlls") then
    local schemastore_avail, schemastore = pcall(require, "schemastore")
    if schemastore_avail then
      lsp_opts.settings = {yaml = {schemas = schemastore.yaml.schemas()}}
    else
    end
  else
  end
  if (server_name == "lua_ls") then
    pcall(require, "neodev")
    local function _96_(param, config)
      if vim.b.neodev_enabled then
        for _, astronvim_config in ipairs(_G.my.astro.supported_configs) do
          if (param.rootPath):match(astronvim_config) then
            table.insert(config.settings.Lua.workspace.library, (_G.my.astro.install.home .. "/lua"))
            break
          else
          end
        end
        return nil
      else
        return nil
      end
    end
    lsp_opts.before_init = _96_
    lsp_opts.settings = {Lua = {workspace = {checkThirdParty = false}}}
  else
  end
  local opts = user_opts((server_config .. server_name), lsp_opts)
  local old_on_attach = server.on_attach
  local user_on_attach = opts.on_attach
  local function _100_(client, bufnr)
    conditional_func(old_on_attach, true, client, bufnr)
    M.on_attach(client, bufnr)
    return conditional_func(user_on_attach, true, client, bufnr)
  end
  opts.on_attach = _100_
  return opts
end
return M

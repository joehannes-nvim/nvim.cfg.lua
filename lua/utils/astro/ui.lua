-- [nfnl] Compiled from fnl/utils/astro/ui.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local function bool2str(bool)
  return ((bool and "on") or "off")
end
local function ui_notify(silent, ...)
  return (not silent and (require("utils.astro")).notify(...))
end
M.toggle_ui_notifications = function(silent)
  vim.g.ui_notifications_enabled = not vim.g.ui_notifications_enabled
  return ui_notify(silent, string.format("Notifications %s", bool2str(vim.g.ui_notifications_enabled)))
end
M.toggle_autopairs = function(silent)
  local ok, autopairs = pcall(require, "nvim-autopairs")
  if ok then
    if autopairs.state.disabled then
      autopairs.enable()
    else
      autopairs.disable()
    end
    vim.g.autopairs_enabled = autopairs.state.disabled
    return ui_notify(silent, string.format("autopairs %s", bool2str(not autopairs.state.disabled)))
  else
    return ui_notify(silent, "autopairs not available")
  end
end
M.toggle_diagnostics = function(silent)
  vim.g.diagnostics_mode = ((vim.g.diagnostics_mode - 1) % 4)
  vim.diagnostic.config(((require("utils.astro.lsp")).diagnostics)[vim.g.diagnostics_mode])
  if (vim.g.diagnostics_mode == 0) then
    return ui_notify(silent, "diagnostics off")
  elseif (vim.g.diagnostics_mode == 1) then
    return ui_notify(silent, "only status diagnostics")
  elseif (vim.g.diagnostics_mode == 2) then
    return ui_notify(silent, "virtual text off")
  else
    return ui_notify(silent, "all diagnostics on")
  end
end
M.toggle_background = function(silent)
  vim.go.background = (((vim.go.background == "light") and "dark") or "light")
  return ui_notify(silent, string.format("background=%s", vim.go.background))
end
M.toggle_cmp = function(silent)
  vim.g.cmp_enabled = not vim.g.cmp_enabled
  local ok, _ = pcall(require, "cmp")
  return ui_notify(silent, ((ok and string.format("completion %s", bool2str(vim.g.cmp_enabled))) or "completion not available"))
end
M.toggle_autoformat = function(silent)
  vim.g.autoformat_enabled = not vim.g.autoformat_enabled
  return ui_notify(silent, string.format("Global autoformatting %s", bool2str(vim.g.autoformat_enabled)))
end
M.toggle_buffer_autoformat = function(bufnr, silent)
  bufnr = (bufnr or 0)
  local old_val = vim.b[bufnr].autoformat_enabled
  if (old_val == nil) then
    old_val = vim.g.autoformat_enabled
  else
  end
  vim.b[bufnr]["autoformat_enabled"] = not old_val
  return ui_notify(silent, string.format("Buffer autoformatting %s", bool2str(vim.b[bufnr].autoformat_enabled)))
end
M.toggle_buffer_semantic_tokens = function(bufnr, silent)
  bufnr = (bufnr or 0)
  do end (vim.b[bufnr])["semantic_tokens_enabled"] = not vim.b[bufnr].semantic_tokens_enabled
  local toggled = false
  for _, client in ipairs(vim.lsp.get_active_clients({bufnr = bufnr})) do
    if client.server_capabilities.semanticTokensProvider then
      vim.lsp.semantic_tokens[((vim.b[bufnr].semantic_tokens_enabled and "start") or "stop")](bufnr, client.id)
      toggled = true
    else
    end
  end
  return ui_notify((not toggled or silent), string.format("Buffer lsp semantic highlighting %s", bool2str(vim.b[bufnr].semantic_tokens_enabled)))
end
M.toggle_buffer_inlay_hints = function(bufnr, silent)
  bufnr = (bufnr or 0)
  do end (vim.b[bufnr])["inlay_hints_enabled"] = not vim.b[bufnr].inlay_hints_enabled
  if vim.lsp.inlay_hint then
    vim.lsp.inlay_hint.enable(bufnr, vim.b[bufnr].inlay_hints_enabled)
    return ui_notify(silent, string.format("Inlay hints %s", bool2str(vim.b[bufnr].inlay_hints_enabled)))
  else
    return nil
  end
end
M.toggle_codelens = function(silent)
  vim.g.codelens_enabled = not vim.g.codelens_enabled
  if not vim.g.codelens_enabled then
    vim.lsp.codelens.clear()
  else
  end
  return ui_notify(silent, string.format("CodeLens %s", bool2str(vim.g.codelens_enabled)))
end
M.toggle_tabline = function(silent)
  vim.opt.showtabline = ((((vim.opt.showtabline):get() == 0) and 2) or 0)
  return ui_notify(silent, string.format("tabline %s", bool2str(((vim.opt.showtabline):get() == 2))))
end
M.toggle_conceal = function(silent)
  vim.opt.conceallevel = ((((vim.opt.conceallevel):get() == 0) and 2) or 0)
  return ui_notify(silent, string.format("conceal %s", bool2str(((vim.opt.conceallevel):get() == 2))))
end
M.toggle_statusline = function(silent)
  local laststatus = (vim.opt.laststatus):get()
  local status = nil
  if (laststatus == 0) then
    vim.opt.laststatus = 2
    status = "local"
  elseif (laststatus == 2) then
    vim.opt.laststatus = 3
    status = "global"
  elseif (laststatus == 3) then
    vim.opt.laststatus = 0
    status = "off"
  else
  end
  return ui_notify(silent, string.format("statusline %s", status))
end
M.toggle_signcolumn = function(silent)
  if (vim.wo.signcolumn == "no") then
    vim.wo.signcolumn = "yes"
  elseif (vim.wo.signcolumn == "yes") then
    vim.wo.signcolumn = "auto"
  else
    vim.wo.signcolumn = "no"
  end
  return ui_notify(silent, string.format("signcolumn=%s", vim.wo.signcolumn))
end
M.set_indent = function(silent)
  local input_avail, input = pcall(vim.fn.input, "Set indent value (>0 expandtab, <=0 noexpandtab): ")
  if input_avail then
    local indent = tonumber(input)
    if (not indent or (indent == 0)) then
      return 
    else
    end
    vim.bo.expandtab = (indent > 0)
    indent = math.abs(indent)
    vim.bo.tabstop = indent
    vim.bo.softtabstop = indent
    vim.bo.shiftwidth = indent
    return ui_notify(silent, string.format("indent=%d %s", indent, ((vim.bo.expandtab and "expandtab") or "noexpandtab")))
  else
    return nil
  end
end
M.change_number = function(silent)
  local number = vim.wo.number
  local relativenumber = vim.wo.relativenumber
  if (not number and not relativenumber) then
    vim.wo.number = true
  elseif (number and not relativenumber) then
    vim.wo.relativenumber = true
  elseif (number and relativenumber) then
    vim.wo.number = false
  else
    vim.wo.relativenumber = false
  end
  return ui_notify(silent, string.format("number %s, relativenumber %s", bool2str(vim.wo.number), bool2str(vim.wo.relativenumber)))
end
M.toggle_spell = function(silent)
  vim.wo.spell = not vim.wo.spell
  return ui_notify(silent, string.format("spell %s", bool2str(vim.wo.spell)))
end
M.toggle_paste = function(silent)
  vim.opt.paste = not (vim.opt.paste):get()
  return ui_notify(silent, string.format("paste %s", bool2str((vim.opt.paste):get())))
end
M.toggle_wrap = function(silent)
  vim.wo.wrap = not vim.wo.wrap
  return ui_notify(silent, string.format("wrap %s", bool2str(vim.wo.wrap)))
end
M.toggle_buffer_syntax = function(bufnr, silent)
  bufnr = (((bufnr and (bufnr ~= 0)) and bufnr) or vim.api.nvim_win_get_buf(0))
  local ts_avail, parsers = pcall(require, "nvim-treesitter.parsers")
  if (vim.bo[bufnr].syntax == "off") then
    if (ts_avail and parsers.has_parser()) then
      vim.treesitter.start(bufnr)
    else
    end
    vim.bo[bufnr]["syntax"] = "on"
    if not vim.b[bufnr].semantic_tokens_enabled then
      M.toggle_buffer_semantic_tokens(bufnr, true)
    else
    end
  else
    if (ts_avail and parsers.has_parser()) then
      vim.treesitter.stop(bufnr)
    else
    end
    vim.bo[bufnr]["syntax"] = "off"
    if vim.b[bufnr].semantic_tokens_enabled then
      M.toggle_buffer_semantic_tokens(bufnr, true)
    else
    end
  end
  return ui_notify(silent, string.format("syntax %s", vim.bo[bufnr].syntax))
end
M.toggle_syntax = M.toggle_buffer_syntax
M.toggle_url_match = function(silent)
  vim.g.highlighturl_enabled = not vim.g.highlighturl_enabled
  do end (require("utils.astro")).set_url_match()
  return ui_notify(silent, string.format("URL highlighting %s", bool2str(vim.g.highlighturl_enabled)))
end
local last_active_foldcolumn = nil
M.toggle_foldcolumn = function(silent)
  local curr_foldcolumn = vim.wo.foldcolumn
  if (curr_foldcolumn ~= "0") then
    last_active_foldcolumn = curr_foldcolumn
  else
  end
  vim.wo.foldcolumn = (((curr_foldcolumn == "0") and (last_active_foldcolumn or "1")) or "0")
  return ui_notify(silent, string.format("foldcolumn=%s", vim.wo.foldcolumn))
end
return M

-- [nfnl] Compiled from fnl/utils/astro/status/component.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local condition = require("utils.astro.status.condition")
local env = require("utils.astro.status.env")
local hl = require("utils.astro.status.hl")
local init = require("utils.astro.status.init")
local provider = require("utils.astro.status.provider")
local status_utils = require("utils.astro.status.utils")
local utils = require("utils.astro")
local buffer_utils = require("utils.astro.buffer")
local extend_tbl = utils.extend_tbl
local get_icon = utils.get_icon
local is_available = utils.is_available
M.fill = function(opts)
  return extend_tbl({provider = provider.fill()}, opts)
end
M.file_info = function(opts)
  opts = extend_tbl({file_icon = {hl = hl.file_icon("statusline"), padding = {left = 1, right = 1}}, file_modified = {padding = {left = 1}}, file_read_only = {padding = {left = 1}}, filename = {}, hl = hl.get_attributes("file_info"), surround = {color = "file_info_bg", condition = condition.has_filetype, separator = "left"}}, opts)
  return M.builder(status_utils.setup_providers(opts, {"file_icon", "unique_path", "filename", "filetype", "file_modified", "file_read_only", "close_button"}))
end
M.tabline_file_info = function(opts)
  local function _1_(self)
    return hl.get_attributes((self.tab_type .. "_close"))
  end
  local function _2_(_, minwid)
    return buffer_utils.close(minwid)
  end
  local function _3_(self)
    return self.bufnr
  end
  local function _4_(self)
    return not self._show_picker
  end
  local function _5_(self)
    local tab_type = self.tab_type
    if (self._show_picker and (self.tab_type ~= "buffer_active")) then
      tab_type = "buffer_visible"
    else
    end
    return hl.get_attributes(tab_type)
  end
  local function _7_(self)
    return hl.get_attributes((self.tab_type .. "_path"))
  end
  return M.file_info(extend_tbl({close_button = {hl = _1_, on_click = {callback = _2_, minwid = _3_, name = "heirline_tabline_close_buffer_callback"}, padding = {left = 1, right = 1}}, file_icon = {condition = _4_, hl = hl.file_icon("tabline")}, hl = _5_, padding = {left = 1, right = 1}, unique_path = {hl = _7_}, surround = false}, opts))
end
M.nav = function(opts)
  opts = extend_tbl({hl = hl.get_attributes("nav"), percentage = {padding = {left = 1}}, ruler = {}, scrollbar = {hl = {fg = "scrollbar"}, padding = {left = 1}}, surround = {color = "nav_bg", separator = "right"}, update = {"CursorMoved", "CursorMovedI", "BufEnter"}}, opts)
  return M.builder(status_utils.setup_providers(opts, {"ruler", "percentage", "scrollbar"}))
end
M.cmd_info = function(opts)
  local function _8_()
    return ((vim.opt.cmdheight):get() == 0)
  end
  local function _9_()
    return vim.cmd.redrawstatus()
  end
  local function _10_()
    return ((condition.is_hlsearch() or condition.is_macro_recording()) or condition.is_statusline_showcmd())
  end
  opts = extend_tbl({condition = _8_, hl = hl.get_attributes("cmd_info"), macro_recording = {condition = condition.is_macro_recording, icon = {kind = "MacroRecording", padding = {right = 1}}, update = {"RecordingEnter", "RecordingLeave", callback = (((vim.fn.has("nvim-0.9") == 0) and vim.schedule_wrap(_9_)) or nil)}}, search_count = {condition = condition.is_hlsearch, icon = {kind = "Search", padding = {right = 1}}, padding = {left = 1}}, showcmd = {condition = condition.is_statusline_showcmd, padding = {left = 1}}, surround = {color = "cmd_info_bg", condition = _10_, separator = "center"}}, opts)
  return M.builder(status_utils.setup_providers(opts, {"macro_recording", "search_count", "showcmd"}))
end
M.mode = function(opts)
  local function _11_()
    return vim.cmd.redrawstatus()
  end
  opts = extend_tbl({hl = hl.get_attributes("mode"), surround = {color = hl.mode_bg, separator = "left"}, update = {"ModeChanged", callback = vim.schedule_wrap(_11_), pattern = "*:*"}, paste = false, mode_text = false, spell = false}, opts)
  if not opts.mode_text then
    opts.str = {str = " "}
  else
  end
  return M.builder(status_utils.setup_providers(opts, {"mode_text", "str", "paste", "spell"}))
end
M.breadcrumbs = function(opts)
  opts = extend_tbl({condition = condition.aerial_available, padding = {left = 1}, update = "CursorMoved"}, opts)
  opts.init = init.breadcrumbs(opts)
  return opts
end
M.separated_path = function(opts)
  opts = extend_tbl({padding = {left = 1}, update = {"BufEnter", "DirChanged"}}, opts)
  opts.init = init.separated_path(opts)
  return opts
end
M.git_branch = function(opts)
  local function _13_()
    if is_available("telescope.nvim") then
      local function _14_()
        return (require("telescope.builtin")).git_branches({use_file_path = true})
      end
      return vim.defer_fn(_14_, 100)
    else
      return nil
    end
  end
  opts = extend_tbl({git_branch = {icon = {kind = "GitBranch", padding = {right = 1}}}, hl = hl.get_attributes("git_branch"), init = init.update_events({"BufEnter"}), on_click = {callback = _13_, name = "heirline_branch"}, surround = {color = "git_branch_bg", condition = condition.is_git_repo, separator = "left"}, update = {"User", pattern = "GitSignsUpdate"}}, opts)
  return M.builder(status_utils.setup_providers(opts, {"git_branch"}))
end
M.git_diff = function(opts)
  local function _16_()
    if is_available("telescope.nvim") then
      local function _17_()
        return (require("telescope.builtin")).git_status({use_file_path = true})
      end
      return vim.defer_fn(_17_, 100)
    else
      return nil
    end
  end
  opts = extend_tbl({added = {icon = {kind = "GitAdd", padding = {left = 1, right = 1}}}, changed = {icon = {kind = "GitChange", padding = {left = 1, right = 1}}}, hl = hl.get_attributes("git_diff"), init = init.update_events({"BufEnter"}), on_click = {callback = _16_, name = "heirline_git"}, removed = {icon = {kind = "GitDelete", padding = {left = 1, right = 1}}}, surround = {color = "git_diff_bg", condition = condition.git_changed, separator = "left"}, update = {"User", pattern = "GitSignsUpdate"}}, opts)
  local function _19_(p_opts, p)
    local out = status_utils.build_provider(p_opts, p)
    if out then
      out.provider = "git_diff"
      out.opts.type = p
      if (out.hl == nil) then
        out.hl = {fg = ("git_" .. p)}
      else
      end
    else
    end
    return out
  end
  return M.builder(status_utils.setup_providers(opts, {"added", "changed", "removed"}, _19_))
end
M.diagnostics = function(opts)
  local function _22_()
    if is_available("telescope.nvim") then
      local function _23_()
        return (require("telescope.builtin")).diagnostics()
      end
      return vim.defer_fn(_23_, 100)
    else
      return nil
    end
  end
  opts = extend_tbl({ERROR = {icon = {kind = "DiagnosticError", padding = {left = 1, right = 1}}}, HINT = {icon = {kind = "DiagnosticHint", padding = {left = 1, right = 1}}}, INFO = {icon = {kind = "DiagnosticInfo", padding = {left = 1, right = 1}}}, WARN = {icon = {kind = "DiagnosticWarn", padding = {left = 1, right = 1}}}, hl = hl.get_attributes("diagnostics"), on_click = {callback = _22_, name = "heirline_diagnostic"}, surround = {color = "diagnostics_bg", condition = condition.has_diagnostics, separator = "left"}, update = {"DiagnosticChanged", "BufEnter"}}, opts)
  local function _25_(p_opts, p)
    local out = status_utils.build_provider(p_opts, p)
    if out then
      out.provider = "diagnostics"
      out.opts.severity = p
      if (out.hl == nil) then
        out.hl = {fg = ("diag_" .. p)}
      else
      end
    else
    end
    return out
  end
  return M.builder(status_utils.setup_providers(opts, {"ERROR", "WARN", "INFO", "HINT"}, _25_))
end
M.treesitter = function(opts)
  opts = extend_tbl({hl = hl.get_attributes("treesitter"), init = init.update_events({"BufEnter"}), str = {icon = {kind = "ActiveTS", padding = {right = 1}}, str = "TS"}, surround = {color = "treesitter_bg", condition = condition.treesitter_available, separator = "right"}, update = {"OptionSet", pattern = "syntax"}}, opts)
  return M.builder(status_utils.setup_providers(opts, {"str"}))
end
M.lsp = function(opts)
  local function _28_()
    return vim.cmd.redrawstatus()
  end
  local function _29_()
    return vim.cmd.redrawstatus()
  end
  local function _30_()
    local function _31_()
      return vim.cmd.LspInfo()
    end
    return vim.defer_fn(_31_, 100)
  end
  opts = extend_tbl({hl = hl.get_attributes("lsp"), lsp_client_names = {icon = {kind = "ActiveLSP", padding = {right = 2}}, str = "LSP", update = {"LspAttach", "LspDetach", "BufEnter", callback = vim.schedule_wrap(_28_)}}, lsp_progress = {padding = {right = 1}, str = "", update = {"User", callback = vim.schedule_wrap(_29_), pattern = "AstroLspProgress"}}, on_click = {callback = _30_, name = "heirline_lsp"}, surround = {color = "lsp_bg", condition = condition.lsp_attached, separator = "right"}}, opts)
  local function _32_(p_opts, p, i)
    return ((p_opts and {status_utils.build_provider(p_opts, provider[p](p_opts)), status_utils.build_provider(p_opts, provider.str(p_opts)), flexible = i}) or false)
  end
  return M.builder(status_utils.setup_providers(opts, {"lsp_progress", "lsp_client_names"}, _32_))
end
M.foldcolumn = function(opts)
  local function _33_(...)
    local char = status_utils.statuscolumn_clickargs(...).char
    local fillchars = (vim.opt_local.fillchars):get()
    if (char == (fillchars.foldopen or get_icon("FoldOpened"))) then
      return vim.cmd("norm! zc")
    elseif (char == (fillchars.foldclose or get_icon("FoldClosed"))) then
      return vim.cmd("norm! zo")
    else
      return nil
    end
  end
  opts = extend_tbl({condition = condition.foldcolumn_enabled, foldcolumn = {padding = {right = 1}}, on_click = {callback = _33_, name = "fold_click"}}, opts)
  return M.builder(status_utils.setup_providers(opts, {"foldcolumn"}))
end
M.numbercolumn = function(opts)
  local function _35_(...)
    local args = status_utils.statuscolumn_clickargs(...)
    if (args.mods):find("c") then
      local dap_avail, dap = pcall(require, "dap")
      if dap_avail then
        return vim.schedule(dap.toggle_breakpoint)
      else
        return nil
      end
    else
      return nil
    end
  end
  opts = extend_tbl({condition = condition.numbercolumn_enabled, numbercolumn = {padding = {right = 1}}, on_click = {callback = _35_, name = "line_click"}}, opts)
  return M.builder(status_utils.setup_providers(opts, {"numbercolumn"}))
end
M.signcolumn = function(opts)
  local function _38_(...)
    local args = status_utils.statuscolumn_clickargs(...)
    if ((args.sign and args.sign.name) and env.sign_handlers[args.sign.name]) then
      return env.sign_handlers[args.sign.name](args)
    else
      return nil
    end
  end
  opts = extend_tbl({condition = condition.signcolumn_enabled, on_click = {callback = _38_, name = "sign_click"}, signcolumn = {}}, opts)
  return M.builder(status_utils.setup_providers(opts, {"signcolumn"}))
end
M.builder = function(opts)
  opts = extend_tbl({padding = {left = 0, right = 0}}, opts)
  local children = {}
  if (opts.padding.left > 0) then
    table.insert(children, {provider = status_utils.pad_string(" ", {left = (opts.padding.left - 1)})})
  else
  end
  for key, entry in pairs(opts) do
    if ((((type(key) == "number") and (type(entry) == "table")) and provider[entry.provider]) and ((entry.opts == nil) or (type(entry.opts) == "table"))) then
      entry.provider = provider[entry.provider](entry.opts)
    else
    end
    children[key] = entry
  end
  if (opts.padding.right > 0) then
    table.insert(children, {provider = status_utils.pad_string(" ", {right = (opts.padding.right - 1)})})
  else
  end
  return ((opts.surround and status_utils.surround(opts.surround.separator, opts.surround.color, children, opts.surround.condition)) or children)
end
return M

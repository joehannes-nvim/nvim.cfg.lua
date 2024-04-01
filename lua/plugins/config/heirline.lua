-- [nfnl] Compiled from fnl/plugins/config/heirline.fnl by https://github.com/Olical/nfnl, do not edit.
local dropbar = _G.dropbar
local conditions = require("heirline.conditions")
local utils = require("heirline.utils")
local function vimode_color()
  return (my.color.my.vimode[(vim.fn.mode() or "n")] or my.color.my.vimode.n)
end
local function setup_colors()
  local dark_mode = ((vim.opt.background):get() == "dark")
  return {primary = (my.color.theme(my.color.my["current-theme"])).primary, secondary = (my.color.theme(my.color.my["current-theme"])).secondary, normal = (my.color.theme(my.color.my["current-theme"])).normal, attention = (my.color.theme(my.color.my["current-theme"])).attention, flow = (my.color.theme(my.color.my["current-theme"])).flow, command = (my.color.theme(my.color.my["current-theme"])).command, aqua = (my.color.theme(my.color.my["current-theme"])).normal, blue = my.color.my.blue, current_bg = ((dark_mode and my.color.my.dark) or my.color.my.light), current_fg = ((dark_mode and my.color.my.light) or my.color.my.dark), dark = my.color.my.dark, diag_error = (my.color.theme(my.color.my["current-theme"])).attention, diag_hint = (my.color.theme(my.color.my["current-theme"])).secondary, diag_info = (my.color.theme(my.color.my["current-theme"])).normal, diag_warn = my.color.my.orange, git_add = (my.color.theme(my.color.my["current-theme"])).flow, git_change = (my.color.theme(my.color.my["current-theme"])).secondary, git_del = (my.color.theme(my.color.my["current-theme"])).attention, gray = (utils.get_highlight("NonText")).fg, green = (my.color.theme(my.color.my["current-theme"])).flow, light = my.color.my.light, magenta = (my.color.theme(my.color.my["current-theme"])).primary, orange = my.color.my.orange, purple = (my.color.theme(my.color.my["current-theme"])).command, red = (my.color.theme(my.color.my["current-theme"])).attention, vimode = vimode_color(), yellow = (my.color.theme(my.color.my["current-theme"])).secondary}
end
local Arrow_left_left
local function _1_(_self)
  return {bg = vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).primary}
end
Arrow_left_left = {hl = _1_, provider = "\238\130\178"}
local Arrow_right_left
local function _2_(_self)
  return {bg = (my.color.theme(my.color.my["current-theme"])).primary, fg = vimode_color(), force = true}
end
Arrow_right_left = {Arrow_left_left, hl = _2_}
local Arrow_right_right = {hl = {bg = "vimode", fg = (my.color.theme(my.color.my["current-theme"])).primary}, provider = "\238\130\176"}
local Arrow_left_right
local function _3_(_self)
  return {bg = (my.color.theme(my.color.my["current-theme"])).primary, fg = vimode_color(), force = true}
end
Arrow_left_right = {Arrow_right_right, hl = _3_}
local Slant_right_right = {hl = {bg = "vimode", fg = "magenta"}, provider = "\238\130\188"}
local Slant_right_left = {hl = {bg = "magenta", fg = "vimode"}, provider = "\238\130\190"}
local Slant_left_left = {hl = {bg = "vimode", fg = "magenta"}, provider = "\238\130\190"}
local Slant_left_right = {hl = {bg = "magenta", fg = "vimode"}, provider = "\238\130\188"}
local Space = {provider = " "}
local Vi_mode
local function _4_(self)
  return {bg = "magenta", bold = true, fg = "dark"}
end
local function _5_(self)
  self.mode = vim.fn.mode()
  return nil
end
local function _6_(self)
  return self.mode_names[self.mode]
end
Vi_mode = {hl = _4_, init = _5_, provider = _6_, static = {mode_names = {["\19"] = "^S", ["\22"] = "^V", ["\22s"] = "^V", ["!"] = "!", R = "R", Rc = "Rc", Rv = "Rv", Rvc = "Rv", Rvx = "Rv", Rx = "Rx", S = "S_", V = "V_", Vs = "Vs", c = "C", cv = "Ex", i = "I", ic = "Ic", ix = "Ix", n = "N", niI = "Ni", niR = "Nr", niV = "Nv", no = "N?", ["no\22"] = "N?", noV = "N?", nov = "N?", nt = "Nt", r = "...", ["r?"] = "?", rm = "M", s = "S", t = "T", v = "V", vs = "Vs"}}}
local File_name_block
local function _7_(self)
  self.filename = vim.api.nvim_buf_get_name(0)
  return nil
end
File_name_block = {init = _7_}
local File_icon_bare
local function _8_(self)
  local filename = self.filename
  local extension = vim.fn.fnamemodify(filename, ":e")
  self.icon, self.icon_color = (require("nvim-web-devicons")).get_icon_color(filename, extension, {default = true})
  return nil
end
local function _9_(self)
  return (self.icon and (self.icon .. " "))
end
File_icon_bare = {init = _8_, provider = _9_}
local File_name
local function _10_(self)
  return self.lfilename
end
local function _11_(self)
  self.lfilename = vim.fn.fnamemodify(self.filename, ":.")
  self.shortened = false
  if (self.lfilename == "") then
    self.lfilename = "[No Name]"
  else
  end
  if not conditions.width_percent_below(#self.lfilename, 0.27) then
    self.lfilename = vim.fn.pathshorten(self.lfilename)
    self.shortened = true
    return nil
  else
    return nil
  end
end
local function _14_()
  return (require("tfm")).open()
end
File_name = {{hl = {bg = "magenta", fg = "dark"}, provider = _10_}, init = _11_, on_click = {callback = _14_, name = "heirline_filename_ranger_current"}}
local File_flags
local function _15_()
  if vim.bo.modified then
    return " [+]"
  else
    return nil
  end
end
local function _17_()
  if (not vim.bo.modifiable or vim.bo.readonly) then
    return " \239\128\163"
  else
    return nil
  end
end
File_flags = {{hl = {fg = "green"}, provider = _15_}, {hl = {fg = "red"}, provider = _17_}}
local File_name_modifer
local function _19_()
  if vim.bo.modified then
    return {bold = true, fg = (my.color.theme(my.color.my["current-theme"])).normal, force = true}
  else
    return nil
  end
end
File_name_modifer = {hl = _19_}
File_name_block = utils.insert(File_name_block, {provider = " "}, {{hl = {bg = "magenta", fg = "dark"}}}, utils.insert(File_name_modifer, File_name), unpack(File_flags))
local File_type
local function _21_()
  return string.upper(vim.bo.filetype)
end
local function _22_()
  local function _23_()
    return vim.cmd("LspInfo")
  end
  return vim.schedule(_23_)
end
File_type = {hl = {fg = "dark"}, provider = _21_, on_click = {callback = _22_, name = "heirline_ft_lsp"}}
local File_encoding
local function _24_()
  local enc = (((vim.bo.fenc ~= "") and vim.bo.fenc) or vim.o.enc)
  return ((enc ~= "utf-8") and enc:upper())
end
File_encoding = {provider = _24_}
local File_format
local function _25_()
  local fmt = vim.bo.fileformat
  return ((fmt ~= "unix") and fmt:upper())
end
File_format = {provider = _25_}
local File_size
local function _26_()
  local suffix = {"b", "k", "M", "G", "T", "P", "E"}
  local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
  fsize = (((fsize < 0) and 0) or fsize)
  if (fsize <= 0) then
    local ___antifnl_rtn_1___ = ("0" .. suffix[1])
    return ___antifnl_rtn_1___
  else
  end
  local i = math.floor((math.log(fsize) / math.log(1024)))
  return string.format("%.2g%s", (fsize / math.pow(1024, i)), suffix[i])
end
File_size = {provider = _26_}
local File_last_modified
local function _28_()
  local ftime = vim.fn.getftime(vim.api.nvim_buf_get_name(0))
  return ((ftime > 0) and os.date("%c", ftime))
end
File_last_modified = {provider = _28_}
local Ruler = {provider = "%7(%l/%3L%):%2c %P"}
local Scroll_bar
local function _29_(self)
  local curr_line = (vim.api.nvim_win_get_cursor(0))[1]
  local lines = vim.api.nvim_buf_line_count(0)
  local i = (math.floor(((curr_line / lines) * (#self.sbar - 1))) + 1)
  return string.rep(self.sbar[i], 2)
end
Scroll_bar = {hl = {fg = "aqua", bg = "magenta"}, provider = _29_, static = {sbar = {"\226\150\129", "\226\150\130", "\226\150\131", "\226\150\132", "\226\150\133", "\226\150\134", "\226\150\135", "\226\150\136"}}}
local LSPActive
local function _30_()
  local function _31_()
    return vim.cmd("LspInfo")
  end
  return vim.defer_fn(_31_, 100)
end
LSPActive = {condition = conditions.lsp_attached, hl = {bg = "magenta", bold = true, fg = "green"}, on_click = {callback = _30_, name = "heirline_LSP"}, provider = "\239\144\163 LSP", update = {"LspAttach", "LspDetach"}}
local Dropbar
local function _32_(self)
  self.data = vim.tbl_get((dropbar.bars or {}), vim.api.nvim_get_current_buf(), vim.api.nvim_get_current_win())
  return self.data
end
local function _33_(self)
  local components = self.data.components
  local children = {}
  for i, c in ipairs(components) do
    local child = {{hl = c.icon_hl, provider = c.icon}, {hl = c.name_hl, provider = c.name}, on_click = {callback = (self.dropbar_on_click_string):format(self.data.buf, self.data.win, i), name = "heirline_dropbar"}}
    if (i < #components) then
      local sep = self.data.separator
      table.insert(child, {hl = sep.icon_hl, on_click = {callback = (self.dropbar_on_click_string):format(self.data.buf, self.data.win, (i + 1))}, provider = sep.icon})
    else
    end
    table.insert(children, child)
  end
  self.child = self:new(children, 1)
  return nil
end
local function _35_(self)
  return (self.child):eval()
end
Dropbar = {condition = _32_, hl = {bg = (my.color.theme(my.color.my["current-theme"])).primary, fg = my.color.my.dark, force = true}, init = _33_, provider = _35_, static = {dropbar_on_click_string = "v:lua.dropbar.on_click_callbacks.buf%s.win%s.fn%s"}}
local Navic
local function _36_(self)
  return (require("nvim-navic")).is_available(vim.api.nvim_get_current_buf())
end
local function _37_(self)
  local data = ((require("nvim-navic")).get_data() or {})
  local children = {}
  for i, d in ipairs(data) do
    local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
    local child
    local function _38_(_, minwid)
      local line, col, winnr = self.dec(minwid)
      return vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), {line, col})
    end
    child = {{hl = self.type_hl[d.type], provider = d.icon}, {on_click = {callback = _38_, minwid = pos, name = "heirline_navic"}, provider = (d.name):gsub("%%", "%%%%"):gsub("%s*->%s*", "")}}
    if ((#data > 1) and (i < #data)) then
      table.insert(child, {provider = " > "})
    else
    end
    table.insert(children, child)
  end
  self.child = self:new(children, 1)
  return nil
end
local function _40_(self)
  return (self.child):eval()
end
local function _41_(c)
  local line = bit.rshift(c, 16)
  local col = bit.band(bit.rshift(c, 6), 1023)
  local winnr = bit.band(c, 63)
  return line, col, winnr
end
local function _42_(line, col, winnr)
  return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
end
Navic = {condition = _36_, hl = {fg = my.color.my.dark}, init = _37_, provider = _40_, static = {dec = _41_, enc = _42_, type_hl = {Array = "@field", Boolean = "@boolean", Class = "@structure", Constant = "@constant", Constructor = "@constructor", Enum = "@field", EnumMember = "@field", Event = "@keyword", Field = "@field", File = "Directory", Function = "@function", Interface = "@type", Key = "@keyword", Method = "@method", Module = "@include", Namespace = "@namespace", Null = "@comment", Number = "@number", Object = "@type", Operator = "@operator", Package = "@include", Property = "@property", String = "@string", Struct = "@structure", TypeParameter = "@type", Variable = "@variable"}}, update = {"CursorMoved", "ModeChanged"}}
local Buffer_local_diagnostics
local function _43_(self)
  return ((self.errors > 0) and ((self.error_icon or " \239\129\151 ") .. self.errors .. " "))
end
local function _44_(self)
  return ((self.warnings > 0) and ((self.warn_icon or " \239\129\177 ") .. self.warnings .. " "))
end
local function _45_(self)
  return ((self.info > 0) and ((self.info_icon or " \239\132\169 ") .. self.info .. " "))
end
local function _46_(self)
  return ((self.hints > 0) and ((self.hint_icon or " \226\152\137 ") .. self.hints))
end
local function _47_(self)
  self.errors = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
  self.warnings = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})
  self.hints = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.HINT})
  self.info = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.INFO})
  return nil
end
local function _48_()
  return vim.cmd("TroubleToggle document_diagnostics")
end
Buffer_local_diagnostics = {{provider = _43_}, {provider = _44_}, {provider = _45_}, {provider = _46_}, condition = conditions.has_diagnostics, init = _47_, on_click = {callback = _48_, name = "heirline_diagnostics"}, static = {error_icon = (vim.fn.sign_getdefined("DiagnosticSignError")).text, hint_icon = (vim.fn.sign_getdefined("DiagnosticSignHint")).text, info_icon = (vim.fn.sign_getdefined("DiagnosticSignInfo")).text, warn_icon = (vim.fn.sign_getdefined("DiagnosticSignWarn")).text}, update = {"DiagnosticChanged", "BufEnter", "BufWinEnter"}}
local Buffer_diagnostics
local function _49_(self)
  return ((self.errors > 0) and ((self.error_icon or " \239\129\151 ") .. self.errors .. " "))
end
local function _50_(self)
  return ((self.warnings > 0) and ((self.warn_icon or " \239\129\177 ") .. self.warnings .. " "))
end
local function _51_(self)
  return ((self.info > 0) and ((self.info_icon or " \239\132\169 ") .. self.info .. " "))
end
local function _52_(self)
  return ((self.hints > 0) and ((self.hint_icon or " \226\152\137 ") .. self.hints))
end
local function _53_(self)
  self.errors = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.ERROR})
  self.warnings = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.WARN})
  self.hints = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.HINT})
  self.info = #vim.diagnostic.get(0, {severity = vim.diagnostic.severity.INFO})
  return nil
end
local function _54_()
  return vim.cmd("TroubleToggle workspace_diagnostics")
end
Buffer_diagnostics = {{hl = {fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).attention, 33)}, provider = _49_}, {hl = {fg = my.color.util.darken(my.color.my.orange, 33)}, provider = _50_}, {hl = {fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).normal, 33)}, provider = _51_}, {hl = {fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).flow, 33)}, provider = _52_}, condition = conditions.has_diagnostics, init = _53_, on_click = {callback = _54_, name = "heirline_diagnostics"}, static = {error_icon = (vim.fn.sign_getdefined("DiagnosticSignError")).text, hint_icon = (vim.fn.sign_getdefined("DiagnosticSignHint")).text, info_icon = (vim.fn.sign_getdefined("DiagnosticSignInfo")).text, warn_icon = (vim.fn.sign_getdefined("DiagnosticSignWarn")).text}, update = {"DiagnosticChanged", "BufWinEnter", "BufEnter"}}
local Diagnostics
local function _55_(self)
  return ((self.errors > 0) and ((self.error_icon or " \239\129\151 ") .. self.errors .. " "))
end
local function _56_(self)
  return ((self.warnings > 0) and ((self.warn_icon or " \239\129\177 ") .. self.warnings .. " "))
end
local function _57_(self)
  return ((self.info > 0) and ((self.info_icon or " \239\132\169 ") .. self.info .. " "))
end
local function _58_(self)
  return ((self.hints > 0) and ((self.hint_icon or " \226\152\137 ") .. self.hints))
end
local function _59_(self)
  self.errors = #vim.diagnostic.get(nil, {severity = vim.diagnostic.severity.ERROR})
  self.warnings = #vim.diagnostic.get(nil, {severity = vim.diagnostic.severity.WARN})
  self.hints = #vim.diagnostic.get(nil, {severity = vim.diagnostic.severity.HINT})
  self.info = #vim.diagnostic.get(nil, {severity = vim.diagnostic.severity.INFO})
  return nil
end
local function _60_()
  return vim.cmd("TroubleToggle workspace_diagnostics")
end
Diagnostics = {{hl = {fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).attention, 33)}, provider = _55_}, {hl = {fg = my.color.util.darken(my.color.my.orange, 33)}, provider = _56_}, {hl = {fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).normal, 33)}, provider = _57_}, {hl = {fg = my.color.util.darken((my.color.theme(my.color.my["current-theme"])).flow, 33)}, provider = _58_}, condition = conditions.has_diagnostics, init = _59_, on_click = {callback = _60_, name = "heirline_diagnostics"}, static = {error_icon = (vim.fn.sign_getdefined("DiagnosticSignError")).text, hint_icon = (vim.fn.sign_getdefined("DiagnosticSignHint")).text, info_icon = (vim.fn.sign_getdefined("DiagnosticSignInfo")).text, warn_icon = (vim.fn.sign_getdefined("DiagnosticSignWarn")).text}, update = {"DiagnosticChanged", "TabEnter"}}
local Git
local function _61_(self)
  return ("\239\144\152 " .. self.status_dict.head)
end
local function _62_(self, minwid, nclicks, button)
  return vim.cmd("Telescope git_branches")
end
local function _63_(self)
  return self.has_changes
end
local function _64_(self)
  local count = (self.status_dict.added or 0)
  return ((count > 0) and ("+" .. count))
end
local function _65_(self)
  local count = (self.status_dict.removed or 0)
  return ((count > 0) and ("-" .. count))
end
local function _66_(self)
  local count = (self.status_dict.changed or 0)
  return ((count > 0) and ("~" .. count))
end
local function _67_(self)
  return self.has_changes
end
local function _68_(self, minwid, nclicks, button)
  return vim.cmd("Neogit")
end
local function _69_(self)
  self.status_dict = vim.b.gitsigns_status_dict
  self.has_changes = (((self.status_dict.added ~= 0) or (self.status_dict.removed ~= 0)) or (self.status_dict.changed ~= 0))
  return nil
end
Git = {Space, {hl = {bold = true, fg = "secondary"}, provider = _61_, on_click = {callback = _62_, name = "heirline_git"}}, Space, {{condition = _63_, provider = "[", hl = {fg = "secondary"}}, {hl = {fg = "green"}, provider = _64_}, {hl = {fg = "red"}, provider = _65_}, {hl = {fg = "orange"}, provider = _66_}, {condition = _67_, provider = "]", hl = {fg = "secondary"}}, on_click = {callback = _68_, name = "heirline_neogit"}}, Space, condition = conditions.is_git_repo, hl = {bg = "magenta", fg = "dark"}, init = _69_}
local Snippets
local function _70_()
  return vim.tbl_contains({"s", "i"}, vim.fn.mode())
end
local function _71_()
  local forward = (((vim.fn["UltiSnips#CanJumpForwards"]() == 1) and "\239\130\169") or "")
  local backward = (((vim.fn["UltiSnips#CanJumpBackwards"]() == 1) and "\239\130\168") or "")
  return (backward .. forward)
end
Snippets = {condition = _70_, hl = {bold = true, fg = "red"}, provider = _71_}
local Work_dir
local function _72_(self)
  local trail = ((((self.cwd):sub(( - 1)) == "/") and "") or "/")
  return (self.icon .. (self.cwd):gsub("~/.local/git", "\239\144\152") .. trail .. " ")
end
local function _73_()
  return (require("tfm")).open(".")
end
local function _74_(self)
  self.icon = ((((vim.fn.haslocaldir(0) == 1) and "l") or "g") .. " " .. "\239\144\147 ")
  local cwd = vim.fn.getcwd(0)
  self.cwd = vim.fn.fnamemodify(cwd, ":~")
  if not conditions.width_percent_below(#self.cwd, 0.27) then
    self.cwd = vim.fn.pathshorten(self.cwd)
    return nil
  else
    return nil
  end
end
Work_dir = {{provider = _72_}, hl = {bold = true, fg = "dark"}, on_click = {callback = _73_, name = "heirline_workdir"}, provider = _74_}
local Help_filename
local function _76_()
  return (vim.bo.filetype == "help")
end
local function _77_()
  local filename = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnamemodify(filename, ":t")
end
Help_filename = {condition = _76_, hl = {fg = "current_fg"}, provider = _77_}
local Terminal_name
local function _78_()
  local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
  return ("\239\146\137 " .. tname)
end
local function _79_()
  return vim.b.term_title
end
local function _80_()
  local id = require("terminal"):current_term_index()
  return (" " .. (id or "Exited"))
end
Terminal_name = {{hl = {bold = true, fg = "blue"}, provider = _78_}, {provider = " - "}, {provider = _79_}, {hl = {bold = true, fg = "blue"}, provider = _80_}}
local Spell
local function _81_()
  return vim.wo.spell
end
Spell = {condition = _81_, hl = {bold = true, fg = "yellow"}, provider = "SPELL "}
local Align = {provider = "%="}
local Default_statusline
local function _82_(self)
  return {bg = "primary", fg = vimode_color(), force = true}
end
Default_statusline = {{Vi_mode, hl = {fg = "vimode", bg = "magenta", force = true}}, Arrow_right_right, Space, Spell, {{Arrow_right_right, hl = _82_}, Space, {Work_dir, hl = {fg = "secondary", force = true}}, Arrow_right_right, hl = {bg = "magenta"}}, Space, {Arrow_left_right, Git, Arrow_right_right, hl = {bg = "magenta"}}, Space, {{Arrow_left_right, hl = {fg = "vimode", bg = "current_fg", force = true}, update = "ModeChanged"}, Diagnostics, Space, {Arrow_right_right, hl = {bg = "vimode", fg = "current_fg", force = true}, update = "ModeChanged"}, condition = conditions.has_diagnostics, hl = {bg = "current_fg", bold = true}, update = "ModeChanged"}, Align, Space, {Arrow_left_left, {Space, File_type, Space, hl = {fg = "secondary", bold = true, bg = "primary", italic = true, force = true}}, Arrow_right_left}, Space, Space, {Arrow_left_left, Space, Ruler, Space, Arrow_right_left, hl = {bg = "magenta", fg = "secondary"}}, Space, Scroll_bar, update = {"VimEnter", "ModeChanged"}, hl = {bg = "vimode"}}
local Inactive_statusline
local function _83_()
  return not conditions.is_active()
end
Inactive_statusline = {{Work_dir, hl = {fg = "gray", force = true}}, File_name_block, {provider = "%<"}, Align, condition = _83_}
local Special_statusline
local function _84_()
  return conditions.buffer_matches({buftype = {"nofile", "prompt", "help", "quickfix"}, filetype = {"^git.*", "fugitive"}})
end
Special_statusline = {{Vi_mode, File_type}, {provider = "%q"}, Space, Help_filename, Align, condition = _84_}
local Git_statusline
local function _85_()
  return vim.fn.FugitiveStatusline()
end
local function _86_()
  return conditions.buffer_matches({filetype = {"^git.*", "fugitive", "neogit", "NeogitStatus"}})
end
Git_statusline = {{Vi_mode, File_type}, Space, {provider = _85_}, Space, Align, condition = _86_}
local Terminal_statusline
local function _87_()
  return conditions.buffer_matches({buftype = {"terminal", "toggleterm"}})
end
Terminal_statusline = {{Vi_mode, Space, condition = conditions.is_active}, File_type, Space, Align, condition = _87_, hl = {bg = "magenta"}}
local Status_lines
local function _88_()
  if conditions.is_active() then
    return {bg = vimode_color()}
  else
    return {bg = (my.color.theme(my.color.my["current-theme"])).primary}
  end
end
local function _90_(self)
  local mode = ((conditions.is_active() and vim.fn.mode()) or "n")
  local current_mode_color = vimode_color()
  vim.api.nvim_set_hl(0, "StatusLine", {bg = current_mode_color})
  return current_mode_color
end
Status_lines = {Git_statusline, Special_statusline, Terminal_statusline, Inactive_statusline, Default_statusline, hl = _88_, static = {mode_color = _90_}, update = {"DirChanged", "VimEnter", "ColorScheme", "ModeChanged", "WinNew"}, fallthrough = false}
local Close_button
local function _91_(_, winid)
  return vim.api.nvim_win_close(winid, true)
end
local function _92_(self)
  return ("heirline_close_button_" .. self.winnr)
end
local function _93_(self)
  return not vim.bo.modified
end
Close_button = {{provider = " "}, {hl = {fg = "gray"}, on_click = {callback = _91_, name = _92_, update = true}, provider = "\239\153\149"}, condition = _93_, update = {"WinNew", "WinClosed", "BufEnter"}}
local Tabline_bufnr
local function _94_(self)
  return (tostring(self.bufnr) .. ". ")
end
Tabline_bufnr = {hl = "Comment", provider = _94_}
local Tabline_file_name
local function _95_(self)
  return {bold = self.is_active, italic = (self.is_active or self.is_visible)}
end
local function _96_(self)
  local filename = self.filename
  filename = (((filename == "") and "[No Name]") or vim.fn.fnamemodify(filename, ":t"))
  return (" " .. filename .. " ")
end
Tabline_file_name = {hl = _95_, provider = _96_}
local Tabline_file_flags
local function _97_(self)
  return vim.api.nvim_buf_get_option(self.bufnr, "modified")
end
local function _98_(self)
  return (not vim.api.nvim_buf_get_option(self.bufnr, "modifiable") or vim.api.nvim_buf_get_option(self.bufnr, "readonly"))
end
local function _99_(self)
  if (vim.api.nvim_buf_get_option(self.bufnr, "buftype") == "terminal") then
    return " \239\146\137 "
  else
    return "\239\128\163"
  end
end
Tabline_file_flags = {{condition = _97_, hl = {fg = (my.color.theme(my.color.my["current-theme"])).secondary}, provider = "[+]"}, {condition = _98_, hl = {bg = my.color.my.black, fg = (my.color.theme(my.color.my["current-theme"])).secondary}, provider = _99_}}
local Tabline_file_name_block
local function _101_(self)
  return (((self.is_active and {fg = (my.color.theme(my.color.my["current-theme"])).primary}) or (self.is_visible and {fg = my.color.my.dark})) or {fg = my.color.util.darken(my.color.my.light, 50)})
end
local function _102_(self)
  if (self.is_active or self.is_visible) then
    return {fg = (my.color.theme(my.color.my["current-theme"])).primary}
  elseif not vim.api.nvim_buf_is_loaded(self.bufnr) then
    return {fg = (my.color.theme(my.color.my["current-theme"])).primary}
  else
    return {}
  end
end
local function _104_(self)
  self.filename = vim.api.nvim_buf_get_name(self.bufnr)
  return nil
end
local function _105_(_, minwid, _0, button)
  if (button == "m") then
    return vim.api.nvim_buf_delete(minwid, {force = false})
  else
    return vim.api.nvim_win_set_buf(0, minwid)
  end
end
local function _107_(self)
  return self.bufnr
end
Tabline_file_name_block = {Tabline_bufnr, {File_icon_bare, hl = _101_}, Tabline_file_name, Tabline_file_flags, hl = _102_, init = _104_, on_click = {callback = _105_, minwid = _107_, name = "heirline_tabline_buffer_callback"}}
local Tabline_close_button
local function _108_(_, minwid)
  return vim.cmd(("bp|bd " .. minwid))
end
local function _109_(self)
  return self.bufnr
end
local function _110_(self)
  return not vim.api.nvim_buf_get_option(self.bufnr, "modified")
end
Tabline_close_button = {{provider = " "}, {hl = {fg = "gray"}, on_click = {callback = _108_, minwid = _109_, name = "heirline_tabline_close_buffer_callback"}, provider = "\239\128\141"}, {provider = " "}, condition = _110_}
local Tabline_picker
local function _111_(self)
  return self._show_picker
end
local function _112_(self)
  local bufname = vim.api.nvim_buf_get_name(self.bufnr)
  bufname = vim.fn.fnamemodify(bufname, ":t")
  local label = bufname:sub(1, 1)
  local i = 2
  while self._picker_labels[label] do
    if (i > #bufname) then
      break
    else
    end
    label = bufname:sub(i, i)
    i = (i + 1)
  end
  self._picker_labels[label] = self.bufnr
  self.label = label
  return nil
end
local function _114_(self)
  return (" " .. self.label)
end
Tabline_picker = {condition = _111_, hl = {bold = true, fg = "red"}, init = _112_, provider = _114_}
local Tabline_buffer_block
local function _115_(self)
  if self.is_active then
    return vimode_color()
  elseif self.is_visible then
    return my.color.util.desaturate(vimode_color(), 50)
  else
    return my.color.util[((vim.opt.background):get() .. "en")](vimode_color(), 50)
  end
end
Tabline_buffer_block = utils.surround({"\238\130\186", "\238\130\184"}, _115_, {Tabline_file_name_block, Tabline_picker, Tabline_close_button})
local Tabpage
local function _117_(self)
  if not self.is_active then
    return "TabLine"
  else
    return {bg = vimode_color(), force = true}
  end
end
local function _119_(self)
  return ("%" .. self.tabnr .. "T " .. self.tabnr .. " %T")
end
Tabpage = {hl = _117_, provider = _119_}
local Tabpage_close
local function _120_(self)
  return (vim.tbl_count(vim.api.nvim_list_tabpages()) > 1)
end
local function _121_()
  vim.api.nvim_win_close(0, true)
  return vim.cmd.redrawtabline()
end
Tabpage_close = {condition = _120_, hl = "TabLine", on_click = {callback = _121_, name = "heirline_tabline_close_tab_callback"}, provider = " \239\128\141 "}
local Tab_pages
local function _122_()
  return (#vim.api.nvim_list_tabpages() >= 2)
end
Tab_pages = {{provider = "%="}, utils.make_tablist(Tabpage), Tabpage_close, condition = _122_}
local Tab_line_offset
local function _123_(self)
  local win = (vim.api.nvim_tabpage_list_wins(0))[1]
  local bufnr = vim.api.nvim_win_get_buf(win)
  self.winid = win
  if (vim.bo[bufnr].filetype == "NvimTree") then
    self.title = "NvimTree"
    return true
  else
    return nil
  end
end
local function _125_(self)
  if (vim.api.nvim_get_current_win() == self.winid) then
    return "TablineSel"
  else
    return "Tabline"
  end
end
local function _127_(self)
  local title = self.title
  local width = vim.api.nvim_win_get_width(self.winid)
  local pad = math.ceil(((width - #title) / 2))
  return (string.rep(" ", pad) .. title .. string.rep(" ", pad))
end
Tab_line_offset = {condition = _123_, hl = _125_, provider = _127_}
local Buffer_line
local function _128_(self)
  local function _129_(bufnr)
    return (not not vim.api.nvim_buf_get_name(bufnr):find(vim.fn.getcwd(), 0, true) and not conditions.buffer_matches({buftype = {".*git.*", "terminal", "nofile", "prompt", "help", "quickfix"}, filetype = {"wilder", "packer", "neo-tree", "which-key", "Diffview.*", "NeogitStatus", ".*git.*", "^git.*", "fugitive"}}, bufnr) and vim.api.nvim_buf_is_loaded(bufnr))
  end
  return vim.tbl_filter(_129_, vim.api.nvim_list_bufs())
end
Buffer_line = utils.make_buflist(Tabline_buffer_block, {hl = {fg = "gray"}, provider = " \239\130\168 "}, {hl = {fg = "gray"}, provider = " \239\130\169 "}, _128_)
local Tab_line
local function _130_(self)
  self.bufferline = Buffer_line
  return nil
end
Tab_line = {Tab_line_offset, Buffer_line, Tab_pages, hl = {bg = (my.color.theme(my.color.my["current-theme"])).primary}, init = _130_, update = {"DirChanged", "BufLeave", "BufEnter", "BufWinEnter", "ModeChanged", "BufModifiedSet", "TabEnter", "OptionSet", "WinNew"}}
local Win_bar
local function _131_(self)
  return {fg = (my.color.theme(my.color.my["current-theme"])).secondary, bold = true, italic = vim.bo.modified, force = true}
end
local function _132_()
  return {bg = (my.color.theme(my.color.my["current-theme"])).primary, fg = my.color.my.dark}
end
local function _133_()
  if (require("nvim-navic")).is_available(vim.api.nvim_get_current_buf()) then
    local data = (require("nvim-navic")).get_data()
    local data_len = 0
    for _, _0 in pairs((data or {})) do
      data_len = (data_len + 1)
    end
    local ___antifnl_rtn_1___ = (data_len > 0)
    return ___antifnl_rtn_1___
  else
  end
  return false
end
local function _135_()
  return {bg = (my.color.theme(my.color.my["current-theme"])).primary, fg = my.color.my.dark}
end
local function _136_()
  if (require("nvim-navic")).is_available(vim.api.nvim_get_current_buf()) then
    local data = (require("nvim-navic")).get_data()
    for _, _0 in pairs((data or {})) do
      return false
    end
  else
  end
  return true
end
local function _138_()
  return {bg = (my.color.theme(my.color.my["current-theme"])).primary, fg = my.color.my.dark}
end
local function _139_(self)
  return {bg = vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).primary, force = true}
end
local function _140_(self)
  return "\238\130\178"
end
local function _141_(self)
  return {bg = vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).secondary, force = true}
end
local function _142_(self)
  return {bg = vimode_color(), fg = (my.color.theme(my.color.my["current-theme"])).secondary, force = true}
end
local function _143_(self)
  return "\238\130\176"
end
local function _144_(self)
  if not conditions.is_active() then
    local ___antifnl_rtn_1___ = {bg = (my.color.theme(my.color.my["current-theme"])).attention, fg = my.color.my.light, force = true}
    return ___antifnl_rtn_1___
  else
  end
  return {bg = (my.color.theme(my.color.my["current-theme"])).secondary, fg = (my.color.theme(my.color.my["current-theme"])).primary, bold = true}
end
local function _146_(self)
  return (" #" .. self.winnr)
end
Win_bar = {{Space, {File_name_block, hl = _131_}, Space, {hl = {bold = true, fg = (my.color.theme(my.color.my["current-theme"])).normal}, provider = "\238\130\177"}, hl = _132_}, {[5] = Space, [6] = {Navic, condition = _133_, hl = _135_}, [7] = {Dropbar, condition = _136_, hl = _138_}}, {hl = _139_, provider = "\238\130\176"}, Align, {{provider = _140_, hl = _141_}, {Buffer_local_diagnostics, Space, hl = {fg = (my.color.theme(my.color.my["current-theme"])).primary, bg = (my.color.theme(my.color.my["current-theme"])).secondary, force = true}}, {hl = _142_, provider = _143_}, condition = conditions.has_diagnostics, hl = _144_, update = {"CursorMoved", "ModeChanged", "BufEnter", "BufWinEnter"}}, Space, {hl = {bg = "vimode", fg = (my.color.theme(my.color.my["current-theme"])).primary, force = true}, provider = "\238\130\178", update = {"ModeChanged"}}, {hl = {bg = (my.color.theme(my.color.my["current-theme"])).primary, fg = my.color.my.dark, force = true}, provider = _146_}, hl = {bg = "vimode", fg = (my.color.theme(my.color.my["current-theme"])).primary}, update = {"CursorMoved", "ModeChanged"}}
local Win_bars
local function _147_()
  return (not conditions.buffer_matches({filetype = {"fennel", "dart", "lua", "clojure", "clojurescript", "clj", "cljs", "ts", "tsx", "typescript", "typescriptreact", "js", "jsx", "javascript", "javascriptreact", "html", "css", "json", "md", "sass", "less", "yml", "yaml"}}) or conditions.buffer_matches({buftype = {".*git.*", "terminal", "nofile", "prompt", "help", "quickfix"}, filetype = {"wilder", "packer", "neo-tree", "which-key", "Diffview.*", "NeogitStatus", ".*git.*", "^git.*", "fugitive"}}))
end
local function _148_()
end
Win_bars = {{condition = _147_, init = _148_}, Win_bar, update = {"ModeChanged", "VimEnter", "ColorScheme", "WinNew", "OptionSet"}, fallthrough = false}
local M = {}
M.update = function()
  local function _149_(self)
    self._win_stl = nil
    return nil
  end
  do end ((require("heirline")).statusline):broadcast(_149_)
  do end (require("heirline.utils")).on_colorscheme(setup_colors())
  vim.api.nvim_set_hl(0, "StatusLine", {bg = my.color.my.vimode[(vim.fn.mode() or "n")]})
  return vim.api.nvim_set_hl(0, "ScrollbarHandle", {bg = my.color.my.vimode[(vim.fn.mode() or "n")]})
end
M.aucmds = function()
  vim.api.nvim_create_augroup("Heirline", {clear = true})
  local function _150_(args)
    local buf = args.buf
    local buftype = vim.tbl_contains({"terminal", "prompt", "nofile", "help", "quickfix"}, vim.bo[buf].buftype)
    local filetype = vim.tbl_contains({"wilder", "packer", "which-key", "Diffview.*", "NeogitStatus", "gitcommit", "fugitive"}, vim.bo[buf].filetype)
    if (buftype or filetype) then
      vim.opt_local.winbar = nil
      return nil
    else
      return nil
    end
  end
  vim.api.nvim_create_autocmd("User", {callback = _150_, group = "Heirline", pattern = "HeirlineInitWinbar"})
  return vim.api.nvim_create_autocmd("ModeChanged", {callback = M.update, group = "Heirline", pattern = "*"})
end
M.load_colors = function()
  return (require("heirline")).load_colors(setup_colors())
end
M.setup = function(my_aucmds)
  do end (require("heirline")).load_colors(setup_colors())
  vim.api.nvim_set_hl(0, "TabLine", {bg = (my.color.theme(my.color.my["current-theme"])).secondary, fg = (my.color.theme(my.color.my["current-theme"])).primary}, vim.api.nvim_set_hl(0, "TabLineSel", {bg = my.color.my.vimode[vim.fn.mode()], fg = my.color.my.dark}))
  vim.api.nvim_set_hl(0, "TabLineFill", {bg = (my.color.theme(my.color.my["current-theme"])).primary})
  vim.api.nvim_set_hl(0, "StatusLine", {bg = vimode_color()})
  vim.api.nvim_set_hl(0, "WinBar", {bg = vimode_color()})
  do end (require("heirline")).setup({statusline = Status_lines, winbar = Win_bars, tabline = Tab_line})
  if (my_aucmds == true) then
    vim.cmd("au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif")
    return M.aucmds()
  else
    return nil
  end
end
M.StatusLines = Status_lines
M.TabLines = Tab_line
M.WinBars = Win_bars
return M

-- [nfnl] Compiled from fnl/utils/astro/status/env.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.fallback_colors = {bg = "#1e222a", blue = "#61afef", bright_grey = "#777d86", bright_purple = "#a9a1e1", bright_red = "#ec5f67", bright_yellow = "#ebae34", dark_bg = "#2c323c", dark_grey = "#5c5c5c", fg = "#abb2bf", green = "#98c379", grey = "#5c6370", none = "NONE", orange = "#ff9640", purple = "#c678dd", red = "#e06c75", white = "#c9c9c9", yellow = "#e5c07b"}
M.modes = {["\19"] = {"BLOCK", "visual"}, ["\22"] = {"BLOCK", "visual"}, ["\22s"] = {"BLOCK", "visual"}, ["!"] = {"SHELL", "inactive"}, R = {"REPLACE", "replace"}, Rc = {"REPLACE", "replace"}, Rv = {"V-REPLACE", "replace"}, Rx = {"REPLACE", "replace"}, S = {"SELECT", "visual"}, V = {"LINES", "visual"}, Vs = {"LINES", "visual"}, c = {"COMMAND", "command"}, ce = {"COMMAND", "command"}, cv = {"COMMAND", "command"}, i = {"INSERT", "insert"}, ic = {"INSERT", "insert"}, ix = {"INSERT", "insert"}, n = {"NORMAL", "normal"}, niI = {"NORMAL", "normal"}, niR = {"NORMAL", "normal"}, niV = {"NORMAL", "normal"}, no = {"OP", "normal"}, ["no\22"] = {"OP", "normal"}, noV = {"OP", "normal"}, nov = {"OP", "normal"}, nt = {"TERM", "terminal"}, null = {"null", "inactive"}, r = {"PROMPT", "inactive"}, ["r?"] = {"CONFIRM", "inactive"}, rm = {"MORE", "inactive"}, s = {"SELECT", "visual"}, t = {"TERM", "terminal"}, v = {"VISUAL", "visual"}, vs = {"VISUAL", "visual"}}
M.separators = _G.my.astro.user_opts("heirline.separators", {breadcrumbs = " \238\130\177 ", center = {"  ", "  "}, left = {"", "  "}, none = {"", ""}, path = " \238\130\177 ", right = {"  ", ""}, tab = {"", " "}})
M.attributes = _G.my.astro.user_opts("heirline.attributes", {buffer_active = {bold = true, italic = true}, buffer_picker = {bold = true}, git_branch = {bold = true}, git_diff = {bold = true}, macro_recording = {bold = true}})
local function _1_(self)
  return (self.is_active or self.is_visible)
end
M.icon_highlights = _G.my.astro.user_opts("heirline.icon_highlights", {file_icon = {statusline = true, tabline = _1_}})
local function pattern_match(str, pattern_list)
  for _, pattern in ipairs(pattern_list) do
    if str:find(pattern) then
      return true
    else
    end
  end
  return false
end
local function _3_(pattern_list, bufnr)
  return pattern_match(vim.fn.fnamemodify(vim.api.nvim_buf_get_name((bufnr or 0)), ":t"), pattern_list)
end
local function _4_(pattern_list, bufnr)
  return pattern_match((vim.bo[(bufnr or 0)]).buftype, pattern_list)
end
local function _5_(pattern_list, bufnr)
  return pattern_match((vim.bo[(bufnr or 0)]).filetype, pattern_list)
end
M.buf_matchers = {bufname = _3_, buftype = _4_, filetype = _5_}
M.sign_handlers = {}
local function gitsigns(_)
  local gitsigns_avail, gitsigns0 = pcall(require, "gitsigns")
  if gitsigns_avail then
    return vim.schedule(gitsigns0.preview_hunk)
  else
    return nil
  end
end
for _, sign in ipairs({"Topdelete", "Untracked", "Add", "Changedelete", "Delete"}) do
  local name = ("GitSigns" .. sign)
  if not M.sign_handlers[name] then
    M.sign_handlers[name] = gitsigns
  else
  end
end
local function diagnostics(args)
  if (args.mods):find("c") then
    return vim.schedule(vim.lsp.buf.code_action)
  else
    return vim.schedule(vim.diagnostic.open_float)
  end
end
for _, sign in ipairs({"Error", "Hint", "Info", "Warn"}) do
  local name = ("DiagnosticSign" .. sign)
  if not M.sign_handlers[name] then
    M.sign_handlers[name] = diagnostics
  else
  end
end
local function dap_breakpoint(_)
  local dap_avail, dap = pcall(require, "dap")
  if dap_avail then
    return vim.schedule(dap.toggle_breakpoint)
  else
    return nil
  end
end
for _, sign in ipairs({"", "Rejected", "Condition"}) do
  local name = ("DapBreakpoint" .. sign)
  if not M.sign_handlers[name] then
    M.sign_handlers[name] = dap_breakpoint
  else
  end
end
M.sign_handlers = _G.my.astro.user_opts("heirline.sign_handlers", M.sign_handlers)
return M

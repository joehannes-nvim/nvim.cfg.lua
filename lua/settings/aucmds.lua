-- [nfnl] Compiled from fnl/settings/aucmds.fnl by https://github.com/Olical/nfnl, do not edit.
local M
local function _1_()
  my.fn.onAfterBoot()
  local function _2_()
    return vim.cmd("SessionLoad")
  end
  return vim.schedule(_2_)
end
local function _3_()
  return my.fn.onModeChanged()
end
local function _4_()
  return my.fn.onColorScheme()
end
local function _5_()
  return vim.cmd("setlocal cursorline cursorcolumn")
end
local function _6_()
  return vim.cmd("setlocal nocursorline nocursorcolumn")
end
local function _7_(_opts)
  return vim.api.nvim_set_option_value("relativenumber", true, {scope = "local"})
end
local function _8_(_opts)
  return vim.api.nvim_set_option_value("relativenumber", false, {scope = "local"})
end
local function _9_(args)
  if not vim.b[args.buf].view_activated then
    local filetype = vim.api.nvim_get_option_value("filetype", {buf = args.buf})
    local buftype = vim.api.nvim_get_option_value("buftype", {buf = args.buf})
    local ignore_filetypes = {"gitcommit", "gitrebase", "svg", "hgcommit"}
    if (((buftype == "") and filetype) and (filetype ~= "") and not vim.tbl_contains(ignore_filetypes, filetype)) then
      vim.b[args.buf]["view_activated"] = true
      return vim.cmd.loadview({mods = {emsg_silent = true}})
    else
      return nil
    end
  else
    return nil
  end
end
local function _12_(args)
  if vim.b[args.buf].view_activated then
    return vim.cmd.mkview({mods = {emsg_silent = true}})
  else
    return nil
  end
end
local function _14_()
  return vim.highlight.on_yank({higroup = "IncSearch", hlgroup = "IncSearch", timeout = 2000})
end
local function _15_()
  return vim.cmd("setlocal nonumber norelativenumber foldcolumn=0 nocursorcolumn")
end
local function _16_()
  return vim.cmd.normal("cwindow")
end
local function _17_()
  return vim.cmd("setlocal spell")
end
local function _18_()
  return vim.cmd("setfiletype markdown")
end
local function _19_()
  return vim.cmd("setfiletype clojure")
end
local function _20_()
  return vim.cmd("setlocal nonumber norelativenumber foldcolumn=0 nocursorline")
end
local function _21_()
end
local function _22_()
  return vim.cmd("ScopeLoadState")
end
local function _23_()
end
local function _24_()
  local function _25_()
  end
  return vim.schedule(_25_)
end
local function _26_()
end
local function _27_()
  return vim.cmd("ScopeSaveState")
end
M = {MyBootAugroup = {[{"VimEnter"}] = {callback = _1_, pattern = "*"}}, MyModeAugroup = {[{"ModeChanged"}] = {callback = _3_, pattern = "*:*"}}, MyColorAugroup = {[{"ColorScheme"}] = {callback = _4_, pattern = "*"}}, MyCursorAugroup = {[{"WinEnter", "BufWinEnter"}] = {callback = _5_, pattern = "*"}, [{"WinLeave"}] = {callback = _6_, pattern = "*"}, [{"BufEnter", "BufWinEnter", "InsertLeave", "FocusGained"}] = {callback = _7_, pattern = "*.*"}, [{"BufLeave", "BufWinLeave", "InsertEnter", "FocusLost"}] = {callback = _8_, pattern = "*.*"}}, MyFoldsAugroup = {[{"BufWinEnter"}] = {{callback = _9_, pattern = "*"}}, [{"BufWinLeave", "BufWritePost", "WinLeave"}] = {{callback = _12_, pattern = "*.*"}}}, MyHighlightAugroup = {[{"TextYankPost"}] = {callback = _14_, pattern = "*"}}, MyListsAugroup = {[{"BufEnter", "BufWinEnter", "FocusGained"}] = {callback = _15_, pattern = {"qf", "trouble", "help"}}, [{"QuickFixCmdPost"}] = {callback = _16_, pattern = "*grep*"}}, MyReadAugroup = {[{"BufNewFile", "BufRead"}] = {{callback = _17_, pattern = {"*.md", "*.org", "*.wiki", "*.dict", "*.txt"}}, {callback = _18_, pattern = {"*.org", "*.wiki"}}, {callback = _19_, pattern = {"*.cljd", "*.cljs"}}}}, MyTerminalAugroup = {[{"TermOpen", "TermEnter"}] = {callback = _20_, pattern = "*"}}, MyWriteAugroup = {[{"BufWritePre"}] = {callback = _21_, pattern = {"*.clj", "*.cljc", "*.cljs"}}}, PersistedHooks = {[{"User"}] = {{callback = _22_, pattern = "PersistedLoadPre"}, {callback = _23_, pattern = "PersistedTelescopeLoadPre"}, {callback = _24_, pattern = "PersistedLoadPost"}, {callback = _26_, pattern = "PersistedTelescopeLoadPost"}, {callback = _27_, pattern = "PersistedSavePre"}}}}
return M

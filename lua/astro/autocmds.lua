-- [nfnl] Compiled from fnl/astro/autocmds.fnl by https://github.com/Olical/nfnl, do not edit.
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local cmd = vim.api.nvim_create_user_command
local namespace = vim.api.nvim_create_namespace
local utils = require("utils.astro")
local is_available = utils.is_available
local astroevent = utils.event
local function _1_(char)
  if (vim.fn.mode() == "n") then
    local new_hlsearch = vim.tbl_contains({"<CR>", "n", "N", "*", "#", "?", "/"}, vim.fn.keytrans(char))
    if ((vim.opt.hlsearch):get() ~= new_hlsearch) then
      vim.opt.hlsearch = new_hlsearch
      return nil
    else
      return nil
    end
  else
    return nil
  end
end
vim.on_key(_1_, namespace("auto_hlsearch"))
local function _4_(args)
  local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
  do end (vim.b[args.buf])["large_buf"] = (((ok and stats) and (stats.size > vim.g.max_file.size)) or (vim.api.nvim_buf_line_count(args.buf) > vim.g.max_file.lines))
  return nil
end
autocmd("BufReadPre", {callback = _4_, desc = "Disable certain functionality on very large files", group = augroup("large_buf", {clear = true})})
local terminal_settings_group = augroup("terminal_settings", {clear = true})
if ((vim.fn.has("nvim-0.9") == 1) and (vim.fn.has("nvim-0.9.4") == 0)) then
  local function _5_()
    vim.opt_local.statuscolumn = nil
    return nil
  end
  autocmd("TermOpen", {callback = _5_, desc = "Disable custom statuscolumn for terminals to fix neovim/neovim#25472", group = terminal_settings_group})
else
end
local function _7_()
  vim.opt_local.foldcolumn = "0"
  vim.opt_local.signcolumn = "no"
  return nil
end
autocmd("TermOpen", {callback = _7_, desc = "Disable foldcolumn and signcolumn for terinals", group = terminal_settings_group})
local bufferline_group = augroup("bufferline", {clear = true})
local function _8_(args)
  local buf_utils = require("utils.astro.buffer")
  if not vim.t.bufs then
    vim.t.bufs = {}
  else
  end
  if not buf_utils.is_valid(args.buf) then
    return 
  else
  end
  if (args.buf ~= buf_utils.current_buf) then
    buf_utils.last_buf = ((buf_utils.is_valid(buf_utils.current_buf) and buf_utils.current_buf) or nil)
    buf_utils.current_buf = args.buf
  else
  end
  local bufs = vim.t.bufs
  if not vim.tbl_contains(bufs, args.buf) then
    table.insert(bufs, args.buf)
    vim.t.bufs = bufs
  else
  end
  vim.t.bufs = vim.tbl_filter(buf_utils.is_valid, vim.t.bufs)
  return astroevent("BufsUpdated")
end
autocmd({"BufAdd", "BufEnter", "TabNewEntered"}, {callback = _8_, desc = "Update buffers when adding new buffers", group = bufferline_group})
local function _13_(args)
  local removed = nil
  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local bufs = vim.t[tab].bufs
    if bufs then
      for i, bufnr in ipairs(bufs) do
        if (bufnr == args.buf) then
          removed = true
          table.remove(bufs, i)
          do end (vim.t[tab])["bufs"] = bufs
          break
        else
        end
      end
    else
    end
  end
  vim.t.bufs = vim.tbl_filter((require("utils.astro.buffer")).is_valid, vim.t.bufs)
  if removed then
    astroevent("BufsUpdated")
  else
  end
  return vim.cmd.redrawtabline()
end
autocmd({"BufDelete", "TermClose"}, {callback = _13_, desc = "Update buffers when deleting buffers", group = bufferline_group})
local function _17_()
  return utils.set_url_match()
end
autocmd({"VimEnter", "FileType", "BufEnter", "WinEnter"}, {callback = _17_, desc = "URL Highlighting", group = augroup("highlighturl", {clear = true})})
local view_group = augroup("auto_view", {clear = true})
local function _18_(args)
  if vim.b[args.buf].view_activated then
    return vim.cmd.mkview({mods = {emsg_silent = true}})
  else
    return nil
  end
end
autocmd({"BufWinLeave", "BufWritePost", "WinLeave"}, {callback = _18_, desc = "Save view with mkview for real files", group = view_group})
local function _20_(args)
  if not vim.b[args.buf].view_activated then
    local filetype = vim.api.nvim_get_option_value("filetype", {buf = args.buf})
    local buftype = vim.api.nvim_get_option_value("buftype", {buf = args.buf})
    local ignore_filetypes = {"gitcommit", "gitrebase", "svg", "hgcommit"}
    if ((((buftype == "") and filetype) and (filetype ~= "")) and not vim.tbl_contains(ignore_filetypes, filetype)) then
      vim.b[args.buf]["view_activated"] = true
      return vim.cmd.loadview({mods = {emsg_silent = true}})
    else
      return nil
    end
  else
    return nil
  end
end
autocmd("BufWinEnter", {callback = _20_, desc = "Try to load file view if available and enable view saving for real files", group = view_group})
local function _23_(args)
  local buftype = vim.api.nvim_get_option_value("buftype", {buf = args.buf})
  if (vim.tbl_contains({"help", "nofile", "quickfix"}, buftype) and (vim.fn.maparg("q", "n") == "")) then
    return vim.keymap.set("n", "q", "<cmd>close<cr>", {buffer = args.buf, desc = "Close window", nowait = true, silent = true})
  else
    return nil
  end
end
autocmd("BufWinEnter", {callback = _23_, desc = "Make q close help, man, quickfix, dap floats", group = augroup("q_close_windows", {clear = true})})
local function _25_()
  return vim.highlight.on_yank()
end
autocmd("TextYankPost", {callback = _25_, desc = "Highlight yanked text", group = augroup("highlightyank", {clear = true}), pattern = "*"})
local function _26_()
  vim.opt_local.buflisted = false
  return nil
end
autocmd("FileType", {callback = _26_, desc = "Unlist quickfist buffers", group = augroup("unlist_quickfist", {clear = true}), pattern = "qf"})
local function _27_()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  if (#wins <= 1) then
    return 
  else
  end
  local sidebar_fts = {aerial = true, ["neo-tree"] = true}
  for _, winid in ipairs(wins) do
    if vim.api.nvim_win_is_valid(winid) then
      local bufnr = vim.api.nvim_win_get_buf(winid)
      local filetype = vim.api.nvim_get_option_value("filetype", {buf = bufnr})
      if not sidebar_fts[filetype] then
        return 
      else
        sidebar_fts[filetype] = nil
      end
    else
    end
  end
  if (#vim.api.nvim_list_tabpages() > 1) then
    return vim.cmd.tabclose()
  else
    return vim.cmd.qall()
  end
end
autocmd("BufEnter", {callback = _27_, desc = "Quit AstroNvim if more than one window is open and only sidebar windows are list", group = augroup("auto_quit", {clear = true})})
if is_available("alpha-nvim") then
  local function _32_(args)
    if ((((args.event == "User") and (args.file == "AlphaReady")) or ((args.event == "BufWinEnter") and (vim.api.nvim_get_option_value("filetype", {buf = args.buf}) == "alpha"))) and not vim.g.before_alpha) then
      vim.g.before_alpha = {cmdheight = (vim.opt.cmdheight):get(), laststatus = (vim.opt.laststatus):get(), showtabline = (vim.opt.showtabline):get()}
      vim.opt.showtabline, vim.opt.laststatus, vim.opt.cmdheight = 0, 0, 0
      return nil
    elseif ((vim.g.before_alpha and (args.event == "BufWinEnter")) and (vim.api.nvim_get_option_value("buftype", {buf = args.buf}) ~= "nofile")) then
      vim.opt.laststatus, vim.opt.showtabline, vim.opt.cmdheight = vim.g.before_alpha.laststatus, vim.g.before_alpha.showtabline, vim.g.before_alpha.cmdheight
      vim.g.before_alpha = nil
      return nil
    else
      return nil
    end
  end
  autocmd({"User", "BufWinEnter"}, {callback = _32_, desc = "Disable status, tablines, and cmdheight for alpha", group = augroup("alpha_settings", {clear = true})})
  local function _34_()
    local should_skip = nil
    local lines = vim.api.nvim_buf_get_lines(0, 0, 2, false)
    local function _35_(bufnr)
      return vim.bo[bufnr].buflisted
    end
    if (((((vim.fn.argc() > 0) or (#lines > 1)) or ((#lines == 1) and ((lines[1]):len() > 0))) or (#vim.tbl_filter(_35_, vim.api.nvim_list_bufs()) > 1)) or not vim.o.modifiable) then
      should_skip = true
    else
      for _, arg in pairs(vim.v.argv) do
        if ((((arg == "-b") or (arg == "-c")) or vim.startswith(arg, "+")) or (arg == "-S")) then
          should_skip = true
          break
        else
        end
      end
    end
    if should_skip then
      return 
    else
    end
    do end (require("alpha")).start(true, (require("alpha")).default_config)
    local function _39_()
      return vim.cmd.doautocmd("FileType")
    end
    return vim.schedule(_39_)
  end
  autocmd("VimEnter", {callback = _34_, desc = "Start Alpha when vim is opened with no arguments", group = augroup("alpha_autostart", {clear = true})})
else
end
if is_available("indent-blankline.nvim") then
  local function _41_()
    if ((vim.fn.has("nvim-0.9") ~= 1) or (vim.v.event.all and (vim.v.event.all.leftcol ~= 0))) then
      return pcall(vim.cmd.IndentBlanklineRefresh)
    else
      return nil
    end
  end
  autocmd("WinScrolled", {callback = _41_, desc = "Refresh indent blankline on window scroll", group = augroup("indent_blankline_refresh_scroll", {clear = true})})
else
end
if is_available("resession.nvim") then
  local function _44_()
    local buf_utils = require("utils.astro.buffer")
    local autosave = buf_utils.sessions.autosave
    if (autosave and buf_utils.is_valid_session()) then
      local save = (require("resession")).save
      if autosave.last then
        save("Last Session", {notify = false})
      else
      end
      if autosave.cwd then
        return save(vim.fn.getcwd(), {dir = "dirsession", notify = false})
      else
        return nil
      end
    else
      return nil
    end
  end
  autocmd("VimLeavePre", {callback = _44_, desc = "Save session on close", group = augroup("resession_auto_save", {clear = true})})
else
end
if is_available("neo-tree.nvim") then
  local function _49_()
    if package.loaded["neo-tree"] then
      return vim.api.nvim_del_augroup_by_name("neotree_start")
    else
      local stats = (vim.uv or vim.loop).fs_stat(vim.api.nvim_buf_get_name(0))
      if (stats and (stats.type == "directory")) then
        vim.api.nvim_del_augroup_by_name("neotree_start")
        return require("neo-tree")
      else
        return nil
      end
    end
  end
  autocmd("BufEnter", {callback = _49_, desc = "Open Neo-Tree on startup with directory", group = augroup("neotree_start", {clear = true})})
  local function _52_()
    local manager_avail, manager = pcall(require, "neo-tree.sources.manager")
    if manager_avail then
      for _, source in ipairs({"filesystem", "git_status", "document_symbols"}) do
        local module = ("neo-tree.sources." .. source)
        if package.loaded[module] then
          manager.refresh(require(module).name)
        else
        end
      end
      return nil
    else
      return nil
    end
  end
  autocmd("TermClose", {callback = _52_, desc = "Refresh Neo-Tree when closing lazygit", group = augroup("neotree_refresh", {clear = true}), pattern = "*lazygit*"})
else
end
local function _56_()
  if vim.g.colors_name then
    for _, module in ipairs({"init", vim.g.colors_name}) do
      for group, spec in pairs(_G.my.astro.user_opts(("highlights." .. module))) do
        vim.api.nvim_set_hl(0, group, spec)
      end
    end
  else
  end
  return astroevent("ColorScheme", false)
end
autocmd("ColorScheme", {callback = _56_, desc = "Load custom highlights from user configuration", group = augroup("astronvim_highlights", {clear = true})})
local function _58_(args)
  local current_file = vim.fn.resolve(vim.fn.expand("%"))
  if not ((current_file == "") or (vim.api.nvim_get_option_value("buftype", {buf = args.buf}) == "nofile")) then
    astroevent("File")
    if ((require("utils.astro.git")).file_worktree() or utils.cmd({"git", "-C", vim.fn.fnamemodify(current_file, ":p:h"), "rev-parse"}, false)) then
      astroevent("GitFile")
      return vim.api.nvim_del_augroup_by_name("file_user_events")
    else
      return nil
    end
  else
    return nil
  end
end
autocmd({"BufReadPost", "BufNewFile", "BufWritePost"}, {callback = _58_, desc = "AstroNvim user events for file detection (AstroFile and AstroGitFile)", group = augroup("file_user_events", {clear = true})})
local function _61_()
  return (require("utils.astro.updater")).changelog()
end
cmd("AstroChangelog", _61_, {desc = "Check AstroNvim Changelog"})
local function _62_()
  return (require("utils.astro.updater")).update_packages()
end
cmd("AstroUpdatePackages", _62_, {desc = "Update Plugins and Mason"})
local function _63_()
  return (require("utils.astro.updater")).rollback()
end
cmd("AstroRollback", _63_, {desc = "Rollback AstroNvim"})
local function _64_()
  return (require("utils.astro.updater")).update()
end
cmd("AstroUpdate", _64_, {desc = "Update AstroNvim"})
local function _65_()
  return (require("utils.astro.updater")).version()
end
cmd("AstroVersion", _65_, {desc = "Check AstroNvim Version"})
local function _66_()
  return (require("utils.astro")).reload()
end
return cmd("AstroReload", _66_, {desc = "Reload AstroNvim (Experimental)"})

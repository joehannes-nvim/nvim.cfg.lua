-- [nfnl] Compiled from fnl/utils/astro/init.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.extend_tbl = function(default, opts)
  opts = (opts or {})
  return ((default and vim.tbl_deep_extend("force", default, opts)) or opts)
end
M.reload = function(quiet)
  local was_modifiable = (vim.opt.modifiable):get()
  if not was_modifiable then
    vim.opt.modifiable = true
  else
  end
  local core_modules = {"_G.my.bootstrap", "_G.my.options", "_G.my.mappings"}
  local modules
  local function _2_(module)
    return module:find("^user%.")
  end
  modules = vim.tbl_filter(_2_, vim.tbl_keys(package.loaded))
  vim.tbl_map((require("plenary.reload")).reload_module, vim.list_extend(modules, core_modules))
  local success = true
  for _, module in ipairs(core_modules) do
    local status_ok, fault = pcall(require, module)
    if not status_ok then
      vim.api.nvim_err_writeln(("Failed to load " .. module .. "\n\n" .. fault))
      success = false
    else
    end
  end
  if not was_modifiable then
    vim.opt.modifiable = false
  else
  end
  if not quiet then
    if success then
      M.notify("AstroNvim successfully reloaded", vim.log.levels.INFO)
    else
      M.notify("Error reloading AstroNvim...", vim.log.levels.ERROR)
    end
  else
  end
  vim.cmd.doautocmd("ColorScheme")
  return success
end
M.list_insert_unique = function(lst, vals)
  if not lst then
    lst = {}
  else
  end
  assert(vim.tbl_islist(lst), "Provided table is not a list like table")
  if not vim.tbl_islist(vals) then
    vals = {vals}
  else
  end
  local added = {}
  local function _9_(v)
    added[v] = true
    return nil
  end
  vim.tbl_map(_9_, lst)
  for _, val in ipairs(vals) do
    if not added[val] then
      table.insert(lst, val)
      do end (added)[val] = true
    else
    end
  end
  return lst
end
M.conditional_func = function(func, condition, ...)
  if (condition and (type(func) == "function")) then
    return func(...)
  else
    return nil
  end
end
M.get_icon = function(kind, padding, no_fallback)
  if (not vim.g.icons_enabled and no_fallback) then
    return ""
  else
  end
  local icon_pack = ((vim.g.icons_enabled and "icons") or "text_icons")
  if not M[icon_pack] then
    M.icons = _G.my.user_opts("icons", require("_G.my.icons.nerd_font"))
    M.text_icons = _G.my.user_opts("text_icons", require("_G.my.icons.text"))
  else
  end
  local icon = (M[icon_pack] and M[icon_pack][kind])
  return ((icon and (icon .. string.rep(" ", (padding or 0)))) or "")
end
M.get_spinner = function(kind, ...)
  local spinner = {}
  while true do
    local icon = M.get_icon(("%s%d"):format(kind, (#spinner + 1)), ...)
    if (icon ~= "") then
      table.insert(spinner, icon)
    else
    end
    if (not icon or (icon == "")) then
      break
    else
    end
  end
  if (#spinner > 0) then
    return spinner
  else
    return nil
  end
end
M.get_hlgroup = function(name, fallback)
  if (vim.fn.hlexists(name) == 1) then
    local hl = nil
    if vim.api.nvim_get_hl then
      hl = vim.api.nvim_get_hl(0, {name = name, link = false})
      if not hl.fg then
        hl.fg = "NONE"
      else
      end
      if not hl.bg then
        hl.bg = "NONE"
      else
      end
    else
      hl = vim.api.nvim_get_hl_by_name(name, vim.o.termguicolors)
      if not hl.foreground then
        hl.foreground = "NONE"
      else
      end
      if not hl.background then
        hl.background = "NONE"
      else
      end
      hl.fg, hl.bg = hl.foreground, hl.background
      hl.ctermfg, hl.ctermbg = hl.fg, hl.bg
      hl.sp = hl.special
    end
    return hl
  else
  end
  return (fallback or {})
end
M.notify = function(msg, type, opts)
  local function _23_()
    return vim.notify(msg, type, M.extend_tbl({title = "AstroNvim"}, opts))
  end
  return vim.schedule(_23_)
end
M.event = function(event, delay)
  local function emit_event()
    return vim.api.nvim_exec_autocmds("User", {pattern = ("Astro" .. event), modeline = false})
  end
  if (delay == false) then
    return emit_event()
  else
    return vim.schedule(emit_event)
  end
end
M.system_open = function(path)
  if vim.ui.open then
    local ___antifnl_rtns_1___ = {vim.ui.open(path)}
    return (table.unpack or _G.unpack)(___antifnl_rtns_1___)
  else
  end
  local cmd = nil
  if ((vim.fn.has("win32") == 1) and (vim.fn.executable("explorer") == 1)) then
    cmd = {"cmd.exe", "/K", "explorer"}
  elseif ((vim.fn.has("unix") == 1) and (vim.fn.executable("xdg-open") == 1)) then
    cmd = {"xdg-open"}
  elseif (((vim.fn.has("mac") == 1) or (vim.fn.has("unix") == 1)) and (vim.fn.executable("open") == 1)) then
    cmd = {"open"}
  else
  end
  if not cmd then
    M.notify("Available system opening tool not found!", vim.log.levels.ERROR)
  else
  end
  return vim.fn.jobstart(vim.fn.extend(cmd, {(path or vim.fn.expand("<cfile>"))}), {detach = true})
end
M.toggle_term_cmd = function(opts)
  local terms = _G.my.user_terminals
  if (type(opts) == "string") then
    opts = {cmd = opts, hidden = true}
  else
  end
  local num = (((vim.v.count > 0) and vim.v.count) or 1)
  if not terms[opts.cmd] then
    terms[opts.cmd] = {}
  else
  end
  if not terms[opts.cmd][num] then
    if not opts.count then
      opts.count = ((vim.tbl_count(terms) * 100) + num)
    else
    end
    if not opts.on_exit then
      local function _31_()
        terms[opts.cmd][num] = nil
        return nil
      end
      opts.on_exit = _31_
    else
    end
    terms[opts.cmd][num] = ((require("toggleterm.terminal")).Terminal):new(opts)
  else
  end
  return (terms[opts.cmd][num]):toggle()
end
M.alpha_button = function(sc, txt)
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<Leader>")
  if vim.g.mapleader then
    sc = sc:gsub("LDR", (((vim.g.mapleader == " ") and "SPC") or vim.g.mapleader))
  else
  end
  local function _35_()
    local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
    return vim.api.nvim_feedkeys(key, "normal", false)
  end
  return {on_press = _35_, opts = {align_shortcut = "right", cursor = ( - 2), hl = "DashboardCenter", hl_shortcut = "DashboardShortcut", position = "center", shortcut = sc, text = txt, width = 36}, type = "button", val = txt}
end
M.is_available = function(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return (lazy_config_avail and (lazy_config.spec.plugins[plugin] ~= nil))
end
M.plugin_opts = function(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  local lazy_plugin_avail, lazy_plugin = pcall(require, "lazy.core.plugin")
  local opts = {}
  if (lazy_config_avail and lazy_plugin_avail) then
    local spec = lazy_config.spec.plugins[plugin]
    if spec then
      opts = lazy_plugin.values(spec, "opts")
    else
    end
  else
  end
  return opts
end
M.load_plugin_with_func = function(plugin, module, func_names)
  if (type(func_names) == "string") then
    func_names = {func_names}
  else
  end
  for _, func in ipairs(func_names) do
    local old_func = module[func]
    local function _39_(...)
      module[func] = old_func
      do end (require("lazy")).load({plugins = {plugin}})
      return module[func](...)
    end
    module[func] = _39_
  end
  return nil
end
M.which_key_register = function()
  if M.which_key_queue then
    local wk_avail, wk = pcall(require, "which-key")
    if wk_avail then
      for mode, registration in pairs(M.which_key_queue) do
        wk.register(registration, {mode = mode})
      end
      M.which_key_queue = nil
      return nil
    else
      return nil
    end
  else
    return nil
  end
end
M.empty_map_table = function()
  local maps = {}
  for _, mode in ipairs({"", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t"}) do
    maps[mode] = {}
  end
  if (vim.fn.has("nvim-0.10.0") == 1) then
    for _, abbr_mode in ipairs({"ia", "ca", "!a"}) do
      maps[abbr_mode] = {}
    end
  else
  end
  return maps
end
M.set_mappings = function(map_table, base)
  base = (base or {})
  for mode, maps in pairs(map_table) do
    for keymap, options in pairs(maps) do
      if options then
        local cmd = options
        local keymap_opts = base
        if (type(options) == "table") then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
          do end (keymap_opts)[1] = nil
        else
        end
        if (not cmd or keymap_opts.name) then
          if not keymap_opts.name then
            keymap_opts.name = keymap_opts.desc
          else
          end
          if not M.which_key_queue then
            M.which_key_queue = {}
          else
          end
          if not M.which_key_queue[mode] then
            M.which_key_queue[mode] = {}
          else
          end
          M.which_key_queue[mode][keymap] = keymap_opts
        else
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      else
      end
    end
  end
  if package.loaded["which-key"] then
    return M.which_key_register()
  else
    return nil
  end
end
M.url_matcher = "\\v\\c%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)%([&:#*@~%_\\-=?!+;/0-9a-z]+%(%([.;/?]|[.][.]+)[&:#*@~%_\\-=?!+/0-9a-z]+|:\\d+|,%(%(%(h?ttps?|ftp|file|ssh|git)://|[a-z]+[@][a-z]+[.][a-z]+:)@![0-9a-z]+))*|\\([&:#*@~%_\\-=?!+;/.0-9a-z]*\\)|\\[[&:#*@~%_\\-=?!+;/.0-9a-z]*\\]|\\{%([&:#*@~%_\\-=?!+;/.0-9a-z]*|\\{[&:#*@~%_\\-=?!+;/.0-9a-z]*})\\})+"
M.delete_url_match = function()
  for _, ___match___ in ipairs(vim.fn.getmatches()) do
    if (___match___.group == "HighlightURL") then
      vim.fn.matchdelete(___match___.id)
    else
    end
  end
  return nil
end
M.set_url_match = function()
  M.delete_url_match()
  if vim.g.highlighturl_enabled then
    return vim.fn.matchadd("HighlightURL", M.url_matcher, 15)
  else
    return nil
  end
end
M.cmd = function(cmd, show_error)
  if (type(cmd) == "string") then
    cmd = {cmd}
  else
  end
  if (vim.fn.has("win32") == 1) then
    cmd = vim.list_extend({"cmd.exe", "/C"}, cmd)
  else
  end
  local result = vim.fn.system(cmd)
  local success = (vim.api.nvim_get_vvar("shell_error") == 0)
  if (not success and ((show_error == nil) or show_error)) then
    vim.api.nvim_err_writeln(("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result))
  else
  end
  return ((success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "")) or nil)
end
return M

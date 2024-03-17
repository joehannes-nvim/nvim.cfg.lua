-- [nfnl] Compiled from fnl/utils/io.fnl by https://github.com/Olical/nfnl, do not edit.
local os_path_sep
do
  local os = string.lower(jit.os)
  if (("linux" == os) or ("osx" == os) or ("bsd" == os)) then
    os_path_sep = "/"
  else
    os_path_sep = "\\"
  end
end
local function echo_21(msg)
  return vim.notify(msg, vim.log.levels.INFO)
end
local function warn_21(msg)
  return vim.notify(msg, vim.log.levels.WARN)
end
local function err_21(msg)
  return vim.notify(msg, vim.log.levels.ERROR)
end
local function spit(path, content)
  local _2_, _3_ = io.open(path, "w")
  if ((_2_ == nil) and (nil ~= _3_)) then
    local msg = _3_
    return error(("Could not open file: " .. msg))
  elseif (nil ~= _2_) then
    local f = _2_
    f:write(content)
    f:flush()
    f:close()
    return nil
  else
    return nil
  end
end
local function slurp(path, silent_3f)
  local _5_, _6_ = io.open(path, "r")
  if ((_5_ == nil) and (nil ~= _6_)) then
    local msg = _6_
    if not silent_3f then
      return error(("Could not open file: " .. msg))
    else
      return nil
    end
  elseif (nil ~= _5_) then
    local f = _5_
    local content = f:read("*all")
    f:close()
    return content
  else
    return nil
  end
end
local function tmpfile(contents)
  local tmp = vim.loop.fs_mktemp()
  if ("table" == type(contents)) then
    spit(tmp, ("\n" .. contents))
  else
    spit(tmp, (contents or ""))
  end
  return tmp
end
local function exists_3f(p)
  local ok, _ = vim.loop.fs_stat(p)
  return ok
end
local function directory_3f(p)
  return vim.fn.isdirectory(p)
end
local function file_3f(p)
  return (exists_3f(p) and not directory_3f(p))
end
local function readable_3f(p)
  return vim.fn.filereadable(p)
end
local function normalize_path(p)
  return vim.fs.normalize(p)
end
local function absolute_path(p)
  return vim.fn.fnamemodify(p, ":p")
end
local function parent_path(p)
  return vim.fn.fnamemodify(p, ":h")
end
local function last_path(p)
  return vim.fn.fnamemodify(p, ":t")
end
local function strip_ext(p)
  return vim.fn.fnamemodify(p, ":r")
end
local function path_extension(p)
  return vim.fn.fnamemodify(p, ":e")
end
local function has_extension(p, any_of)
  local ext = path_extension(p)
  return vim.tbl_contains(any_of, ext)
end
local function path_components(s)
  local done_3f = false
  local acc = {}
  local index = 1
  while not done_3f do
    local start, _end = string.find(s, os_path_sep, index)
    if ("nil" == type(start)) then
      do
        local component = string.sub(s, index)
        if not string["blank?"](component) then
          table.insert(acc)
        else
        end
      end
      done_3f = true
    else
      do
        local component = string.sub(s, index, (start - 1))
        if not string["blank?"](component) then
          table.insert(acc)
        else
        end
      end
      index = (_end + 1)
    end
  end
  return acc
end
local function mkdirp(dir)
  return vim.loop.fs_mkdir(dir, "p")
end
local function expand(...)
  return vim.fn.expand(...)
end
local function concat(...)
  return table.concat({...}, os_path_sep)
end
local function get_clipboard()
  return vim.fn.getreg("+", nil)
end
local function set_clipboard(contents)
  assert(("string" == type(contents)))
  return vim.fn.setreg("+", contents, nil)
end
local function map(mode, lhs, rhs, opts, reverse_repeat)
  local default_opts = {silent = true}
  opts = (((type(opts) == "table") and my.struc.table_merge(default_opts, opts, {expr = true})) or my.struc.table_merge(default_opts, {expr = true}))
  local function repeat_cmd(forward, cmd, _opts, desc)
    local C = {}
    local wording = ((forward and "repeat") or "reverse")
    desc = ((desc and (wording .. ": " .. desc)) or (wording .. " last action"))
    local is_expr = (type(cmd) == "function")
    local additional_opts = ((is_expr and my.struc.table_merge({desc = desc}, {expr = true, replace_keycodes = true})) or {desc = desc})
    _opts = my.struc.table_merge((_opts or {}), additional_opts)
    if ((not forward and (type(cmd) == "string")) and string.match(cmd, "<%a%-%w+>")) then
      C.Cmd = function()
        return vim.cmd.normal(vim.api.nvim_replace_termcodes(cmd, true, true, true))
      end
    else
    end
    return vim.keymap.set("n", ((forward and "<C-.>") or "<C-,>"), (C.Cmd or cmd), _opts)
  end
  local function compile_cmd()
    local defaults = {desc = (opts.desc or nil), lhs = lhs, mode = mode, opts = default_opts, rhs = rhs}
    local reverse_rhs = (reverse_repeat or "<Nop>")
    local my_cmd = rhs
    local function _14_()
      if (mode == "n") then
        repeat_cmd(true, rhs, defaults.opts, (defaults.desc or nil))
        repeat_cmd(false, reverse_rhs, defaults.opts, (defaults.desc or nil))
      else
      end
      if (type(my_cmd) == "function") then
        my_cmd()
        return 
      else
      end
      return my_cmd
    end
    return _14_
  end
  return vim.keymap.set(mode, lhs, compile_cmd(), opts)
end
local function apply_keymaps(mode, keymaps, lhs)
  local wk = require("which-key")
  lhs = (lhs or "")
  for k, v in ipairs(keymaps) do
    if (not (type(v) == "table") and (k > 2)) then
      return 
    elseif (type(v) == "table") then
      if ((((#keymaps > 2) and (type(keymaps[1]) == "string")) and (type(keymaps[2]) == "table")) and (type(keymaps[3]) == "string")) then
        wk.register({[(lhs or keymaps[1])] = {name = keymaps[3]}})
      else
      end
      apply_keymaps(mode, v, lhs)
    elseif ((type(v) == "string") and (k == 1)) then
      lhs = (lhs .. v)
    elseif ((k == 2) and ((type(v) == "string") or (type(v) == "function"))) then
      map(mode, lhs, v, {desc = (((#keymaps > 2) and keymaps[3]) or lhs)}, (((#keymaps > 3) and keymaps[4]) or nil))
    else
      vim.notify_once(("Error in keymapping:" .. mode .. ":<" .. lhs .. ">, <= lhs is a function, should be a string!"))
    end
  end
  return nil
end
return {["echo!"] = echo_21, ["warn!"] = warn_21, ["err!"] = err_21, spit = spit, slurp = slurp, tmpfile = tmpfile, ["exists?"] = exists_3f, ["directory?"] = directory_3f, ["file?"] = file_3f, ["readable?"] = readable_3f, ["normalize-path"] = normalize_path, ["absolute-path"] = absolute_path, ["parent-path"] = parent_path, ["last-path"] = last_path, ["strip-ext"] = strip_ext, ["path-extension"] = path_extension, ["path-components"] = path_components, ["has-extension"] = has_extension, mkdirp = mkdirp, expand = expand, concat = concat, ["get-clipboard"] = get_clipboard, ["set-clipboard"] = set_clipboard, map = map, apply_keymaps = apply_keymaps}

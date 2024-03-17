-- [nfnl] Compiled from fnl/utils/git.fnl by https://github.com/Olical/nfnl, do not edit.
local my = _G.my
local api, vfn, cmd, g, ft = vim.api, vim.fn, vim.cmd, vim.g, vim.bo.filetype
local M = {}
local function get_dir_contains(path, dirname)
  local function pathname(path0)
    local prefix = ""
    local i = path0:find("[\\/:][^\\/:]*$")
    if i then
      prefix = path0:sub(1, (i - 1))
    else
    end
    return prefix
  end
  local function up_one_level(path0)
    if (path0 == nil) then
      path0 = "."
    else
    end
    if (path0 == ".") then
      path0 = io.popen("cd"):read("*l")
    else
    end
    return pathname(path0)
  end
  local function has_specified_dir(path0, specified_dir)
    if (path0 == nil) then
      path0 = "."
    else
    end
    return my.fs.isdir((path0 .. "/" .. specified_dir))
  end
  if (path == nil) then
    path = "."
  else
  end
  if has_specified_dir(path, dirname) then
    return (path .. "/" .. dirname)
  else
    local parent_path = up_one_level(path)
    if (parent_path == path) then
      return nil
    else
      return get_dir_contains(parent_path, dirname)
    end
  end
end
_G["get-root-dir"] = function(path)
  local function pathname(path0)
    local prefix = ""
    local i = path0:find("[\\/:][^\\/:]*$")
    if i then
      prefix = path0:sub(1, (i - 1))
    else
    end
    return prefix
  end
  local function has_git_dir(dir)
    local git_dir = (dir .. "/.git")
    if my.fs.isdir(git_dir) then
      return git_dir
    else
      return nil
    end
  end
  local function has_git_file(dir)
    local gitfile = io.open((dir .. "/.git"))
    if not gitfile then
      return false
    else
    end
    local git_dir = gitfile:read():match("gitdir: (.*)")
    gitfile:close()
    return (git_dir and (dir .. "/" .. git_dir))
  end
  if (not path or (path == ".")) then
    path = io.popen("cd"):read("*l")
  else
  end
  local parent_path = pathname(path)
  return ((has_git_dir(path) or has_git_file(path)) or (((parent_path ~= path) and M.get_root_dir(parent_path)) or nil))
end
_G["check-workspace"] = function()
  local current_file = vfn.expand("%:p")
  if ((current_file == "") or (current_file == nil)) then
    return false
  else
  end
  local current_dir = nil
  if (vfn.getftype(current_file) == "link") then
    local real_file = vfn.resolve(current_file)
    current_dir = vfn.fnamemodify(real_file, ":h")
  else
    current_dir = vfn.expand("%:p:h")
  end
  local result = M.get_root_dir(current_dir)
  if not result then
    return false
  else
  end
  return true
end
_G["get-branch"] = function()
  if (ft == "help") then
    return 
  else
  end
  local current_file = vfn.expand("%:p")
  local current_dir = nil
  if (vfn.getftype(current_file) == "link") then
    local real_file = vfn.resolve(current_file)
    current_dir = vfn.fnamemodify(real_file, ":h")
  else
    current_dir = vfn.expand("%:p:h")
  end
  local ok_gpwd, gitbranch_pwd = pcall(api.nvim_buf_get_var, 0, "gitbranch_pwd")
  local ok_gpath, gitbranch_path = pcall(api.nvim_buf_get_var, 0, "gitbranch_path")
  if (ok_gpwd and ok_gpath) then
    if (gitbranch_path:find(current_dir) and (string.len(gitbranch_pwd) ~= 0)) then
      local ___antifnl_rtn_1___ = gitbranch_pwd
      return ___antifnl_rtn_1___
    else
    end
  else
  end
  local git_dir = M.get_root_dir(current_dir)
  if not git_dir then
    return ""
  else
  end
  local git_root = nil
  if not git_dir:find("/.git") then
    git_root = git_dir
  else
  end
  git_root = git_dir:gsub("/.git", "")
  local head_file = (git_dir and io.open((git_dir .. "/HEAD")))
  if not head_file then
    return ""
  else
  end
  local HEAD = head_file:read()
  head_file:close()
  local branch_name = HEAD:match("ref: refs/heads/(.+)")
  if (branch_name == nil) then
    return ""
  else
  end
  api.nvim_buf_set_var(0, "gitbranch_pwd", branch_name)
  api.nvim_buf_set_var(0, "gitbranch_path", git_root)
  return (branch_name or "")
end
return M

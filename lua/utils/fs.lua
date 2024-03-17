-- [nfnl] Compiled from fnl/utils/fs.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.which = function(executable)
  if (jit.os == "Windows") then
    return vim.fn.system({("(gcm " .. executable .. ").Source")})
  else
    return vim.fn.system({"which", executable}):gsub("%\n$", "")
  end
end
M.path_sep = (((jit.os == "Windows") and "\\") or "/")
M.dir = {cache = vim.fn.stdpath("cache"), cfg = vim.fn.stdpath("config"), data = vim.fn.stdpath("data"), home = vim.fn.getenv("HOME"), plugins = (vim.fn.stdpath("config") .. M.path_sep .. "site" .. M.path_sep .. "pack" .. M.path_sep)}
M.path = {node = M.which("neovim-node-host"), python = M.which("python3"), python2 = M.which("python2"), python3 = M.which("python3")}
M.exists = function(file_or_dir)
  if ((file_or_dir == "") or (file_or_dir == nil)) then
    return false
  else
  end
  local ok, err, code = vim.fn.rename(file_or_dir, file_or_dir)
  if not ok then
    if (code == 13) then
      return true
    else
    end
  else
  end
  return ok, err
end
M.isdir = function(path)
  if ((path == "") or (path == nil)) then
    return false
  else
  end
  return M.exists((path .. "/"))
end
return M

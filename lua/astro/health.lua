-- [nfnl] Compiled from fnl/astro/health.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local health = {error = (vim.health.error or vim.health.report_error), info = (vim.health.info or vim.health.report_info), ok = (vim.health.ok or vim.health.report_ok), start = (vim.health.start or vim.health.report_start), warn = (vim.health.warn or vim.health.report_warn)}
M.check = function()
  health.start("MyDotsNvim")
  health.info(("MyDotsNvim Version: " .. (require("lib.astro.updater")).version(true)))
  health.info(("Neovim Version: v" .. vim.fn.matchstr(vim.fn.execute("version"), "NVIM v\\zs[^\n]*")))
  if vim.version().prerelease then
    health.warn("Neovim nightly is not officially supported and may have breaking changes")
  elseif (vim.fn.has("nvim-0.8") == 1) then
    health.ok("Using stable Neovim >= 0.8.0")
  else
    health.error("Neovim >= 0.8.0 is required")
  end
  local programs
  local function _2_(program)
    local git_version = (require("lib.astro.git")).git_version()
    if git_version then
      if ((git_version.major < 2) or ((git_version.major == 2) and (git_version.min < 19))) then
        program.msg = ("Git %s installed, >= 2.19.0 is required"):format(git_version.str)
        return nil
      else
        return true
      end
    else
      program.msg = "Unable to validate git version"
      return nil
    end
  end
  programs = {{cmd = {"git"}, extra_check = _2_, msg = "Used for core functionality such as updater and plugin management", type = "error"}, {cmd = {"xdg-open", "open", "explorer"}, msg = "Used for `gx` mapping for opening files with system opener (Optional)", type = "warn"}, {cmd = {"lazygit"}, msg = "Used for mappings to pull up git TUI (Optional)", type = "warn"}, {cmd = {"node"}, msg = "Used for mappings to pull up node REPL (Optional)", type = "warn"}, {cmd = {"gdu"}, msg = "Used for mappings to pull up disk usage analyzer (Optional)", type = "warn"}, {cmd = {"btm"}, msg = "Used for mappings to pull up system monitor (Optional)", type = "warn"}, {cmd = {"python", "python3"}, msg = "Used for mappings to pull up python REPL (Optional)", type = "warn"}}
  for _, program in ipairs(programs) do
    local name = table.concat(program.cmd, "/")
    local found = false
    for _0, cmd in ipairs(program.cmd) do
      if (vim.fn.executable(cmd) == 1) then
        name = cmd
        if (not program.extra_check or program.extra_check(program)) then
          found = true
        else
        end
        break
      else
      end
    end
    if found then
      health.ok(("`%s` is installed: %s"):format(name, program.msg))
    else
      health[program.type](("`%s` is not installed: %s"):format(name, program.msg))
    end
  end
  return nil
end
return M

-- [nfnl] Compiled from fnl/utils/astro/updater.fnl by https://github.com/Olical/nfnl, do not edit.
local git = require("utils.astro.git")
local M = {}
local utils = require("utils.astro")
local notify = utils.notify
local function echo(messages)
  messages = (messages or {{"\n"}})
  if (type(messages) == "table") then
    return vim.api.nvim_echo(messages, false, {})
  else
    return nil
  end
end
local function confirm_prompt(messages, type)
  return (vim.fn.confirm(messages, "&Yes\n&No", ((((type == "Error") or (type == "Warning")) and 2) or 1), (type or "Question")) == 1)
end
M.generate_snapshot = function(write)
  local file = nil
  local prev_snapshot = require(_G.my.astro.updater.snapshot.module)
  for _, plugin in ipairs(prev_snapshot) do
    prev_snapshot[plugin[1]] = plugin
  end
  local plugins = assert((require("lazy")).plugins())
  local function _2_(l, r)
    return (l[1] < r[1])
  end
  table.sort(plugins, _2_)
  local function git_commit(dir)
    local commit = assert(utils.cmd({"git", "-C", dir, "rev-parse", "HEAD"}, false))
    if commit then
      return vim.trim(commit)
    else
      return nil
    end
  end
  if (write == true) then
    file = assert(io.open(_G.my.astro.updater.snapshot.path, "w"))
    file:write("return {\n")
  else
  end
  local snapshot
  local function _5_(plugin)
    plugin = {plugin[1], commit = git_commit(plugin.dir), version = plugin.version}
    if (prev_snapshot[plugin[1]] and (prev_snapshot[plugin[1]]).version) then
      plugin.version = (prev_snapshot[plugin[1]]).version
    else
    end
    if file then
      file:write(("  { %q, "):format(plugin[1]))
      if plugin.version then
        file:write(("version = %q"):format(plugin.version))
      else
        file:write(("commit = %q"):format(plugin.commit))
      end
      file:write(", optional = true },\n")
    else
    end
    return plugin
  end
  snapshot = vim.tbl_map(_5_, plugins)
  if file then
    file:write("}\n")
    file:close()
  else
  end
  return snapshot
end
M.version = function(quiet)
  local version = ((_G.my.astro.install.version or git.current_version(false)) or "unknown")
  if (_G.my.astro.updater.options.channel ~= "stable") then
    version = ("nightly (%s)"):format(version)
  else
  end
  if (version and not quiet) then
    notify(("Version: *%s*"):format(version))
  else
  end
  return version
end
M.changelog = function(quiet)
  local summary = {}
  vim.list_extend(summary, git.pretty_changelog(git.get_commit_range()))
  if not quiet then
    echo(summary)
  else
  end
  return summary
end
local function attempt_update(target, opts)
  if ((opts.channel == "stable") or opts.commit) then
    return git.checkout(target, false)
  else
    return git.pull(false)
  end
end
local cancelled_message = {{"Update cancelled", "WarningMsg"}}
M.update_packages = function()
  do end (require("lazy")).sync({wait = true})
  return (require("utils.astro.mason")).update_all()
end
M.create_rollback = function(write)
  local snapshot = {branch = git.current_branch(), commit = git.local_head()}
  if (snapshot.branch == "HEAD") then
    snapshot.branch = "main"
  else
  end
  snapshot.remote = (git.branch_remote(snapshot.branch, false) or "origin")
  snapshot.remotes = {[snapshot.remote] = git.remote_url(snapshot.remote)}
  if (write == true) then
    local file = assert(io.open(_G.my.astro.updater.rollback_file, "w"))
    file:write(("return " .. vim.inspect(snapshot, {indent = "", newline = " "})))
    file:close()
  else
  end
  return snapshot
end
M.rollback = function()
  local rollback_avail, rollback_opts = pcall(dofile, _G.my.astro.updater.rollback_file)
  if not rollback_avail then
    notify("No rollback file available", vim.log.levels.ERROR)
    return 
  else
  end
  return M.update(rollback_opts)
end
M.update_available = function(opts)
  if not opts then
    opts = _G.my.astro.updater.options
  else
  end
  opts = (require("utils.astro")).extend_tbl({remote = "origin"}, opts)
  if not git.available() then
    notify("`git` command is not available, please verify it is accessible in a command line. This may be an issue with your `PATH`", vim.log.levels.ERROR)
    return 
  else
  end
  if not git.is_repo() then
    notify("Updater not available for non-git installations", vim.log.levels.ERROR)
    return 
  else
  end
  for remote, entry in pairs(((opts.remotes and opts.remotes) or {})) do
    local url = git.parse_remote_url(entry)
    local current_url = git.remote_url(remote, false)
    local check_needed = false
    if not current_url then
      git.remote_add(remote, url)
      check_needed = true
    elseif ((current_url ~= url) and confirm_prompt((("Remote %s is currently: %s\n" .. "Would you like us to set it to %s ?")):format(remote, current_url, url))) then
      git.remote_update(remote, url)
      check_needed = true
    else
    end
    if (check_needed and (git.remote_url(remote, false) ~= url)) then
      vim.api.nvim_err_writeln(("Error setting up remote " .. remote .. " to " .. url))
      return 
    else
    end
  end
  local is_stable = (opts.channel == "stable")
  if is_stable then
    opts.branch = "main"
  elseif not opts.branch then
    opts.branch = "nightly"
  else
  end
  if not git.ref_verify((opts.remote .. "/" .. opts.branch), false) then
    git.remote_set_branches(opts.remote, opts.branch, false)
  else
  end
  if not git.fetch(opts.remote) then
    vim.api.nvim_err_writeln(("Error fetching remote: " .. opts.remote))
    return 
  else
  end
  if not is_stable then
    local local_branch = ((((opts.remote == "origin") and "") or (opts.remote .. "_")) .. opts.branch)
    if (git.current_branch() ~= local_branch) then
      echo({{"Switching to branch: "}, {(opts.remote .. "/" .. opts.branch .. "\n\n"), "String"}})
      if not git.checkout(local_branch, false) then
        git.checkout(("-b " .. local_branch .. " " .. opts.remote .. "/" .. opts.branch), false)
      else
      end
    else
    end
    if (git.current_branch() ~= local_branch) then
      vim.api.nvim_err_writeln(("Error checking out branch: " .. opts.remote .. "/" .. opts.branch))
      return 
    else
    end
  else
  end
  local update = {source = git.local_head()}
  if is_stable then
    local version_search = (opts.version or "latest")
    update.version = git.latest_version(git.get_versions(version_search))
    if not update.version then
      vim.api.nvim_err_writeln(("Error finding version: " .. version_search))
      return 
    else
    end
    update.target = git.tag_commit(update.version)
  elseif opts.commit then
    update.target = ((git.branch_contains(opts.remote, opts.branch, opts.commit) and opts.commit) or nil)
  else
    update.target = git.remote_head(opts.remote, opts.branch)
  end
  if (not update.source or not update.target) then
    vim.api.nvim_err_writeln("Error checking for updates")
    return nil
  elseif (update.source ~= update.target) then
    return update
  else
    return false
  end
end
M.update = function(opts)
  if not opts then
    opts = _G.my.astro.updater.options
  else
  end
  opts = (require("utils.astro")).extend_tbl({remote = "origin", show_changelog = true, sync_plugins = true, auto_quit = false}, opts)
  local available_update = M.update_available(opts)
  if (available_update == nil) then
    return nil
  elseif not available_update then
    return notify("No updates available")
  elseif (not opts.skip_prompts and not confirm_prompt(("Update available to %s\nUpdating requires a restart, continue?"):format((available_update.version or available_update.target)))) then
    echo(cancelled_message)
    return nil
  else
    local source, target = available_update.source, available_update.target
    M.create_rollback(true)
    local changelog = git.get_commit_range(source, target)
    local breaking = git.breaking_changes(changelog)
    if (((#breaking > 0) and not opts.skip_prompts) and not confirm_prompt(("Update contains the following breaking changes:\n%s\nWould you like to continue?"):format(table.concat(breaking, "\n")), "Warning")) then
      echo(cancelled_message)
      return 
    else
    end
    local updated = attempt_update(target, opts)
    if ((not updated and not opts.skip_prompts) and not confirm_prompt("Unable to pull due to local modifications to base files.\nReset local files and continue?", "Error")) then
      echo(cancelled_message)
      return 
    elseif not updated then
      git.hard_reset(source)
      updated = attempt_update(target, opts)
    else
    end
    if not updated then
      vim.api.nvim_err_writeln("Error occurred performing update")
      return 
    else
    end
    local summary = {{"AstroNvim updated successfully to ", "Title"}, {git.current_version(), "String"}, {"!\n", "Title"}, {((opts.auto_quit and "AstroNvim will now update plugins and quit.\n\n") or "After plugins update, please restart.\n\n"), "WarningMsg"}}
    if (opts.show_changelog and (#changelog > 0)) then
      vim.list_extend(summary, {{"Changelog:\n", "Title"}})
      vim.list_extend(summary, git.pretty_changelog(changelog))
    else
    end
    echo(summary)
    if opts.auto_quit then
      vim.api.nvim_create_autocmd("User", {command = "quitall", desc = "Auto quit AstroNvim after update completes", pattern = "AstroUpdateComplete"})
    else
    end
    do end (require("lazy.core.plugin")).load()
    if opts.sync_plugins then
      do end (require("lazy")).sync({wait = true})
    else
    end
    return utils.event("UpdateComplete")
  end
end
return M

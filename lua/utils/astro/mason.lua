-- [nfnl] Compiled from fnl/utils/astro/mason.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
local utils = require("lit.astro")
local astroevent = utils.event
local function mason_notify(msg, type)
  return utils.notify(msg, type, {title = "Mason"})
end
M.update = function(pkg_names, auto_install)
  pkg_names = (pkg_names or {})
  if (type(pkg_names) == "string") then
    pkg_names = {pkg_names}
  else
  end
  if (auto_install == nil) then
    auto_install = true
  else
  end
  local registry_avail, registry = pcall(require, "mason-registry")
  if not registry_avail then
    vim.api.nvim_err_writeln("Unable to access mason registry")
    return 
  else
  end
  local function _4_(success, updated_registries)
    if success then
      local count = #updated_registries
      if (vim.tbl_count(pkg_names) == 0) then
        mason_notify(("Successfully updated %d %s."):format(count, (((count == 1) and "registry") or "registries")))
      else
      end
      for _, pkg_name in ipairs(pkg_names) do
        local pkg_avail, pkg = pcall(registry.get_package, pkg_name)
        if not pkg_avail then
          mason_notify(("`%s` is not available"):format(pkg_name), vim.log.levels.ERROR)
        else
          if not pkg:is_installed() then
            if auto_install then
              mason_notify(("Installing `%s`"):format(pkg.name))
              pkg:install()
            else
              mason_notify(("`%s` not installed"):format(pkg.name), vim.log.levels.WARN)
            end
          else
            local function _7_(update_available, version)
              if update_available then
                mason_notify(("Updating `%s` to %s"):format(pkg.name, version.latest_version))
                local function _8_()
                  return mason_notify(("Updated %s"):format(pkg.name))
                end
                return pkg:install():on("closed", _8_)
              else
                return mason_notify(("No updates available for `%s`"):format(pkg.name))
              end
            end
            pkg:check_new_version(_7_)
          end
        end
      end
      return nil
    else
      return mason_notify(("Failed to update registries: %s"):format(updated_registries), vim.log.levels.ERROR)
    end
  end
  return registry.update(vim.schedule_wrap(_4_))
end
M.update_all = function()
  local registry_avail, registry = pcall(require, "mason-registry")
  if not registry_avail then
    vim.api.nvim_err_writeln("Unable to access mason registry")
    return 
  else
  end
  mason_notify("Checking for package updates...")
  local function _14_(success, updated_registries)
    if success then
      local installed_pkgs = registry.get_installed_packages()
      local running = #installed_pkgs
      local no_pkgs = (running == 0)
      if no_pkgs then
        mason_notify("No updates available")
        return astroevent("MasonUpdateCompleted")
      else
        local updated = false
        for _, pkg in ipairs(installed_pkgs) do
          local function _15_(update_available, version)
            if update_available then
              updated = true
              mason_notify(("Updating `%s` to %s"):format(pkg.name, version.latest_version))
              local function _16_()
                running = (running - 1)
                if (running == 0) then
                  mason_notify("Update Complete")
                  return astroevent("MasonUpdateCompleted")
                else
                  return nil
                end
              end
              return pkg:install():on("closed", _16_)
            else
              running = (running - 1)
              if (running == 0) then
                if updated then
                  mason_notify("Update Complete")
                else
                  mason_notify("No updates available")
                end
                return astroevent("MasonUpdateCompleted")
              else
                return nil
              end
            end
          end
          pkg:check_new_version(_15_)
        end
        return nil
      end
    else
      return mason_notify(("Failed to update registries: %s"):format(updated_registries), vim.log.levels.ERROR)
    end
  end
  return registry.update(vim.schedule_wrap(_14_))
end
return M

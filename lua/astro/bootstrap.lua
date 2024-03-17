-- [nfnl] Compiled from fnl/astro/bootstrap.fnl by https://github.com/Olical/nfnl, do not edit.
_G.my.astro.install = (_G.astronvim_installation or {home = vim.fn.stdpath("config")})
_G.my.astro.supported_configs = {_G.my.astro.install.home}
_G.my.astro.install.config = vim.fn.stdpath("config"):gsub("[^/\\]+$", "astro")
if (_G.my.astro.install.home ~= _G.my.astro.install.config) then
  do end (vim.opt.rtp):append(_G.my.astro.install.config)
  table.insert(_G.my.astro.supported_configs, _G.my.astro.install.config)
else
end
local function load_module_file(module)
  local found_file = nil
  for _, config_path in ipairs(_G.my.astro.supported_configs) do
    local module_path = (config_path .. "/fnl/" .. module:gsub("%.", "/") .. ".fnl")
    if (vim.fn.filereadable(module_path) == 1) then
      found_file = module_path
    else
    end
  end
  local out = nil
  if found_file then
    local status_ok, loaded_module = pcall(require, module)
    if status_ok then
      out = loaded_module
    else
      vim.api.nvim_err_writeln(("Error loading file: " .. found_file .. "\n\n" .. loaded_module))
    end
  else
  end
  return out
end
local function func_or_extend(overrides, default, extend)
  if extend then
    if (type(overrides) == "table") then
      local opts = (overrides or {})
      default = ((default and vim.tbl_deep_extend("force", default, opts)) or opts)
    elseif (type(overrides) == "function") then
      default = overrides(default)
    else
    end
  elseif (overrides ~= nil) then
    default = overrides
  else
  end
  return default
end
local user_settings = load_module_file("user.init")
local function user_setting_table(module)
  local settings = (user_settings or {})
  for tbl in string.gmatch(module, "([^%.]+)") do
    settings = settings[tbl]
    if (settings == nil) then
      break
    else
    end
  end
  return settings
end
_G.my.astro.user_opts = function(module, default, extend)
  if (extend == nil) then
    extend = true
  else
  end
  if (default == nil) then
    default = {}
  else
  end
  local user_module_settings = load_module_file(("user." .. module))
  if (user_module_settings == nil) then
    user_module_settings = user_setting_table(module)
  else
  end
  if (user_module_settings ~= nil) then
    default = func_or_extend(user_module_settings, default, extend)
  else
  end
  return default
end
_G.my.astro.user_terminals = {}
_G.my.astro.lsp = {progress = {}, skip_setup = _G.my.astro.user_opts("lsp.skip_setup", {})}
return nil

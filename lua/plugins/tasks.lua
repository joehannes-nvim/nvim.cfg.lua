-- [nfnl] Compiled from fnl/plugins/tasks.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("plugins.config.sniprun")).setup()
end
return {{"Zeioth/compiler.nvim", cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"}, dependencies = {"stevearc/overseer.nvim"}, opts = {}}, {"stevearc/overseer.nvim", opts = {task_list = {default_detail = 1, direction = "bottom", max_height = 25, min_height = 25}}}, {"michaelb/sniprun", build = "bash ./install.sh", config = _1_}}

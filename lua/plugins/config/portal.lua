-- [nfnl] Compiled from fnl/plugins/config/portal.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  return (require("portal")).setup({jump = {keys = {backward = "<c-o>", forward = "<c-i>"}, labels = {escape = {["<esc>"] = true}, select = {"j", "k", "h", "l"}}, query = {"modified", "different", "valid"}}, window = {portal = {options = {border = "single", col = 2, height = 3, noautocmd = true, relative = "cursor", width = 80, zindex = 99, focusable = false}, render_empty = false}, title = {options = {border = "single", col = 2, height = 1, noautocmd = true, relative = "cursor", style = "minimal", width = 80, zindex = 98, focusable = false}, render_empty = true}}})
end
return M

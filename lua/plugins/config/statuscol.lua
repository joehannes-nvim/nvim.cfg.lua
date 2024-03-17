-- [nfnl] Compiled from fnl/plugins/config/statuscol.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local statuscol = require("statuscol")
  local builtin = require("statuscol.builtin")
  local cfg = {clickhandlers = {DapBreakpoint = builtin.toggle_breakpoint, DapBreakpointCondition = builtin.toggle_breakpoint, DapBreakpointRejected = builtin.toggle_breakpoint, DiagnosticSignError = builtin.diagnostic_click, DiagnosticSignHint = builtin.diagnostic_click, DiagnosticSignInfo = builtin.diagnostic_click, DiagnosticSignWarn = builtin.diagnostic_click, FoldClose = builtin.foldclose_click, FoldOpen = builtin.foldopen_click, FoldOther = builtin.foldother_click, GitSignsAdd = builtin.gitsigns_click, GitSignsChange = builtin.gitsigns_click, GitSignsChangedelete = builtin.gitsigns_click, GitSignsDelete = builtin.gitsigns_click, GitSignsTopdelete = builtin.gitsigns_click, GitSignsUntracked = builtin.gitsigns_click, Lnum = builtin.lnum_click, gitsigns_extmark_signs_ = builtin.gitsigns_click}, lnumfunc = nil, segments = {{click = "v:lua.ScFa", text = {"%C"}}, {click = "v:lua.ScSa", text = {"%s"}}, {click = "v:lua.ScLa", condition = {true, builtin.not_empty}, text = {builtin.lnumfunc, " "}}}, separator = "\226\148\130", setopt = true, relculright = false, reeval = false, thousands = false}
  return statuscol.setup(cfg)
end
return M

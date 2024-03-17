(local M {})

(fn M.setup []
  (let [statuscol (require :statuscol)
        builtin (require :statuscol.builtin)
        cfg {:clickhandlers {:DapBreakpoint builtin.toggle_breakpoint
                             :DapBreakpointCondition builtin.toggle_breakpoint
                             :DapBreakpointRejected builtin.toggle_breakpoint
                             :DiagnosticSignError builtin.diagnostic_click
                             :DiagnosticSignHint builtin.diagnostic_click
                             :DiagnosticSignInfo builtin.diagnostic_click
                             :DiagnosticSignWarn builtin.diagnostic_click
                             :FoldClose builtin.foldclose_click
                             :FoldOpen builtin.foldopen_click
                             :FoldOther builtin.foldother_click
                             :GitSignsAdd builtin.gitsigns_click
                             :GitSignsChange builtin.gitsigns_click
                             :GitSignsChangedelete builtin.gitsigns_click
                             :GitSignsDelete builtin.gitsigns_click
                             :GitSignsTopdelete builtin.gitsigns_click
                             :GitSignsUntracked builtin.gitsigns_click
                             :Lnum builtin.lnum_click
                             :gitsigns_extmark_signs_ builtin.gitsigns_click}
             :lnumfunc nil
             :reeval false
             :relculright false
             :segments [{:click "v:lua.ScFa" :text ["%C"]}
                        {:click "v:lua.ScSa" :text ["%s"]}
                        {:click "v:lua.ScLa"
                         :condition [true builtin.not_empty]
                         :text [builtin.lnumfunc " "]}]
             :separator "│"
             :setopt true
             :thousands false}]
    (statuscol.setup cfg)))

M


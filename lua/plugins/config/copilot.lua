-- [nfnl] Compiled from fnl/plugins/config/copilot.fnl by https://github.com/Olical/nfnl, do not edit.
local G = {}
G.setup = function()
  vim.cmd("    highlight CopilotSuggestion guifg=#EEEE00 ctermfg=8\n    let g:copilot_no_tab_map = v:true\n  ")
  return vim.cmd(" imap <silent><script><expr> <s-right> copilot#Accept(\"\\<CR>\")")
end
return G

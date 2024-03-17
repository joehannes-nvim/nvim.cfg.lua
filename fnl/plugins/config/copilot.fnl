(local G {})

(fn G.setup []
  (vim.cmd "    highlight CopilotSuggestion guifg=#EEEE00 ctermfg=8
    let g:copilot_no_tab_map = v:true
  ")
  (vim.cmd " imap <silent><script><expr> <s-right> copilot#Accept(\"\\<CR>\")"))

G


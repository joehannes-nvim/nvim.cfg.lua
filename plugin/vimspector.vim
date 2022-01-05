fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

" let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [ 'debugger-for-chrome', 'vscode-node-debug2' ]

nmap <leader>d<leader> <Plug>VimspectorContinue<CR>
nmap <leader>d<esc> <Plug>VimspectorStop<CR>
nmap <leader>d<c-CR> <Plug>VimSpectorRestart<CR>
nmap <leader>d<backspace> <Plug>VimspectorPause<CR>
nmap <leader>tb <Plug>VimspectorToggleBreakpoint<CR>
nmap <leader>tBc <Plug>VimspectorToggleConditionalBreakpoint<CR>
nmap <leader>tBf <Plug>VimspectorAddFunctionalBreakpoint<CR>
nmap <leader>dl <Plug>VimspectorStepOver<CR>
nmap <leader>dj <Plug>VimspectorStepInto<CR>
nmap <leader>dk <Plug>VimspectorStepOut<CR>
nmap <leader>d<CR> <Plug>VimSpectorRunToCursor<CR>

" Integration with telescope.nvim
nmap <leader>vc :lua require('telescope').extensions.vimspector.configurations()<CR>

" Inspection
nnoremap <leader>dgc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dgt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dgv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dgw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>dgs :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
nnoremap <leader>dgo :call GotoWindow(g:vimspector_session_windows.output)<CR>
-- [nfnl] Compiled from fnl/plugins/config/ultest.fnl by https://github.com/Olical/nfnl, do not edit.
vim.cmd("let test#javascript#jest#options = \"--color=always\"")
vim.cmd("let test#javascript#reactscripts#options = \"--watchAll=false\"")
return vim.cmd("let g:test#typescript#patterns = g:test#javascript#patterns")

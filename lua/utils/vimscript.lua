-- [nfnl] Compiled from fnl/utils/vimscript.fnl by https://github.com/Olical/nfnl, do not edit.
return vim.cmd("  function! WinMove(key)\n      let t:curwin = winnr()\n      exec \"wincmd \".a:key\n      if (t:curwin == winnr())\n          if (match(a:key,'[jk]'))\n              wincmd v\n          else\n              wincmd s\n          endif\n          exec \"wincmd \".a:key\n      endif\n  endfunction\n\n  function! ToggleQuickFix()\n    if empty(filter(getwininfo(), 'v:val.quickfix'))\n      copen\n    else\n      cclose\n    endif\n\9endfunction\n\n\9function! ToggleLocList()\n    if empty(filter(getwininfo(), 'v:val.loclist'))\n      lopen\n    else\n      lclose\n    endif\n\9endfunction\n\n  function! ToggleDiagQF()\n    if empty(filter(getwininfo(), 'v:val.quickfix'))\n        lua require(\"diaglist\").open_all_diagnostics()\n    else\n        cclose\n    endif\n\9endfunction\n\n\9function! ToggleDiagLL()\n    if empty(filter(getwininfo(), 'v:val.loclist'))\n      lua require(\"diaglist\").open_buffer_diagnostics()\n    else\n      lclose\n    endif\n\9endfunction\n")

[[:renerocksai/calendar-vim]
 {1 :renerocksai/telekasten.nvim
  :config (fn []
            ((. (require :telekasten) :setup) {:home (vim.fn.expand "~/zettelkasten")})
            (vim.cmd "        hi tkLink ctermfg=Blue cterm=bold,underline guifg=Blue gui=bold,underline
        hi tkBrackets ctermfg=Magenta guifg=Magenta
      "))
  :dependencies [:nvim-telescope/telescope.nvim]}]


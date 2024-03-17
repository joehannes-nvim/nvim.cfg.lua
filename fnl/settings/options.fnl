(local indent 2)

(local M {:clipboard "unnamed,unnamedplus"
          :cursorline true
          :cursorcolumn true
          :expandtab true
          :exrc true
          :foldcolumn :1
          :foldenable true
          :foldlevel 99
          :foldlevelstart 99
          :foldmethod "expr"
          :grepprg "rg --vimgrep"
          :grepformat "%f:%l:%c:%m"
          :hidden true
          :ignorecase true
          :inccommand :split
          :list true
          :number true
          :qftf "{info -> v:lua.my.ui.qftf(info)}"
          :relativenumber true
          :scrolloff 7
          :sessionoptions "blank,globals,resize,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
          :shiftwidth indent
          :signcolumn "auto:1"
          :softtabstop indent
          :splitbelow true
          :splitright true
          :tabstop indent
          :termguicolors false
          :timeoutlen 200
          :undofile true
          :updatetime 300
          :virtualedit :all
          :mousemoveevent true})

M


[[:williamboman/mason.nvim]
 [:williamboman/mason-lspconfig.nvim]
 [:neovim/nvim-lspconfig]
 [:jose-elias-alvarez/typescript.nvim]
 {1 :onsails/lspkind-nvim
  :config (fn []
            ((. (require :plugins.config.lspkind) :setup)))}
 {1 :creativenull/efmls-configs-nvim
  :dependencies [:neovim/nvim-lspconfig]}
 {1 :lukas-reineke/lsp-format.nvim
  :config (fn []
            ((. (require :lsp-format) :setup) {:sync true}))}
 {1 :weilbith/nvim-code-action-menu
  :cmd :CodeActionMenu}
 {1 :smjonas/inc-rename.nvim
  :config (fn []
            ((. (require :inc_rename) :setup)))}
 {1 :folke/lsp-colors.nvim
  :config (fn []
            ((. (require :plugins.config.lspcolors) :setup)))}
 {1 :soulis-1256/eagle.nvim
  :lazy false
  :config (fn [] ((. (require :eagle) :setup) {}))}
 {1 :VidocqH/lsp-lens.nvim
  :config (fn [] ((. (require :lsp-lens) :setup) {}))}]

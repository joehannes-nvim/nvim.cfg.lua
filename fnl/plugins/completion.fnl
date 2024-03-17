[{1 :codota/tabnine-nvim
  :build "./dl_binaries.sh"
  :config #((. (require :tabnine) :setup) {:disable_auto_comment true
                                           :accept_keymap "<C-Tab>"
                                           :dismiss_keymap "<C-BS>"
                                           :debounce_ms 500
                                           :suggestion_color {:gui "#abba37"}
                                           :exclude_filetypes [:TelescopePrompt :NvimTree]
                                           :log_file_path nil})}
 {1 :hrsh7th/nvim-cmp
  :config (fn []
            ((. (require :plugins.config.completion) :setup))
            ((. (require :cmp-npm) :setup) {}))
  :dependencies [:nvim-lua/plenary.nvim
                 :hrsh7th/cmp-nvim-lsp
                 :saadparwaiz1/cmp_luasnip
                 :hrsh7th/cmp-buffer
                 :hrsh7th/cmp-nvim-lua
                 :octaltree/cmp-look
                 :hrsh7th/cmp-path
                 :hrsh7th/cmp-calc
                 :f3fora/cmp-spell
                 :hrsh7th/cmp-emoji
                 :ray-x/cmp-treesitter
                 :hrsh7th/cmp-cmdline
                 :hrsh7th/cmp-nvim-lsp-document-symbol
                 :hrsh7th/cmp-nvim-lsp-signature-help
                 :David-Kunz/cmp-npm
                 :windwp/nvim-autopairs]}
 [:saadparwaiz1/cmp_luasnip]
 [:hrsh7th/cmp-nvim-lsp]
 [:hrsh7th/cmp-buffer]
 [:hrsh7th/cmp-nvim-lua]
 [:octaltree/cmp-look]
 [:hrsh7th/cmp-path]
 [:hrsh7th/cmp-calc]
 [:f3fora/cmp-spell]
 [:hrsh7th/cmp-emoji]
 [:ray-x/cmp-treesitter]
 [:hrsh7th/cmp-cmdline]
 [:hrsh7th/cmp-nvim-lsp-document-symbol]
 [:hrsh7th/cmp-nvim-lsp-signature-help]
 [:David-Kunz/cmp-npm]
 {1 :tzachar/cmp-tabnine
  :build :./install.sh
  :config (fn []
            (local tabnine (require :cmp_tabnine.config))
            (tabnine:setup {:ignored_file_types {}
                            :max_lines 50
                            :max_num_results 3
                            :run_on_every_keystroke true
                            :show_prediction_strength false
                            :snippet_placeholder ".."
                            :sort true}))
  :dependencies [:hrsh7th/nvim-cmp]}
 [:windwp/nvim-autopairs]]


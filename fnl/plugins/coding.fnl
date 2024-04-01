[{1 "huynle/ogpt.nvim"
  :event :VeryLazy
  :opts {:default_provider :gemini
         :edgy true
         :single_window false
         :yank_register "+"
         :providers {:gemini {:enabled true
                              :api_host (os.getenv "GEMINI_API_HOST")
                              :api_key (os.getenv "GEMINI_API_KEY")
                              :model "gemini-pro"
                              :api_params {:temperature 0.5
                                           :topP 0.99}
                              :api_chat_params {:temperature 0.5
                                                 :topP 0.99}}}
         :edit {:edgy true}
         :popup {:edgy true}
         :chat {:edgy true}}
  :dependencies ["MunifTanjim/nui.nvim"
                 "nvim-lua/plenary.nvim"
                 "nvim-telescope/telescope.nvim"]}
 {1 :glacambre/firenvim
  :lazy (not vim.g.started_by_firenvim)
  :build #((. vim.fn "firenvim#install") 0)}
 {1 :nvim-treesitter/nvim-treesitter
  :branch :master
  :build ":TSUpdate"
  :config (. (require :plugins.config.treesitter) :ts_setup)}
 {1 :nvim-treesitter/nvim-treesitter-refactor
  :config (. (require :plugins.config.treesitter) :ts_refactor_setup)}
 [:nvim-treesitter/nvim-treesitter-textobjects]
 {1 :chrisgrieser/nvim-various-textobjs
  :config (. (require :plugins.config.treesitter) :ts_vto_setup)}
 [:RRethy/nvim-treesitter-textsubjects]
 {1 :nvim-treesitter/nvim-treesitter-context
  :config (fn []
            ((. (require :treesitter-context) :setup)))}
 [:mfussenegger/nvim-ts-hint-textobject]
 [:wellle/targets.vim]
 {1 :mizlan/iswap.nvim
  :config (fn []
            ((. (require :iswap) :setup)))}
 {1 :folke/todo-comments.nvim
  :config (fn []
            ((. (require :todo-comments) :setup)))
  :dependencies :nvim-lua/plenary.nvim}
 {1 :JoosepAlviste/nvim-ts-context-commentstring
  :config (fn []
            (set vim.g.skip_ts_context_commentstring_module true)
            ((. (require :ts_context_commentstring) :setup) {}))}
 [:haringsrob/nvim_context_vt]
 [:machakann/vim-sandwich]
 [:windwp/nvim-ts-autotag]
 [:p00f/nvim-ts-rainbow]
 {1 :windwp/nvim-autopairs
  :config (fn []
            ((. (require :plugins.config.autopairs) :setup)))
  :dependencies [:windwp/nvim-ts-autotag]}
 {1 :numToStr/Comment.nvim
  :config (fn []
            ((. (require :Comment) :setup)))}
 [:antoinemadec/FixCursorHold.nvim]
 {1 :nvim-neotest/neotest
  :dependencies [:nvim-lua/plenary.nvim
                 :nvim-treesitter/nvim-treesitter
                 :antoinemadec/FixCursorHold.nvim]}
 {1 :folke/neodev.nvim
  :config (fn []
            ((. (require :neodev) :setup) {:library {:plugins [:neotest]
                                                     :types true}}))}
 {1 :akinsho/flutter-tools.nvim
  :opts {:root_patterns ["pubspec.yaml"]}
  :config true
  :dependencies [:nvim-lua/plenary.nvim :stevearc/dressing.nvim]
  :lazy false}
 {1 :luckasRanarison/nvim-devdocs
  :dependencies ["nvim-lua/plenary.nvim"
                 "nvim-telescope/telescope.nvim"
                 "nvim-treesitter/nvim-treesitter"]
  :opts {}
  :config (fn [] ((. (require :nvim-devdocs) :setup) {:float_win  {:relative "editor"
                                                                   :height 30
                                                                   :width 140
                                                                   :border "rounded"}
                                                      :after_open (fn [] (vim.api.nvim_buf_set_keymap 0 "n" "<Esc>" ":close<CR>" {}))}))}
 [:sheerun/vim-polyglot]
 [:othree/es.next.syntax.vim]
 [:othree/javascript-libraries-syntax.vim]
 {1 :MaximilianLloyd/tw-values.nvim
  :opts {:border :rounded
         :copy_register ""
         :focus_preview true
         :keymaps {:copy :<C-y>}
         :show_unknown_classes true}}
 {1 :luckasRanarison/tailwind-tools.nvim
  :opts {}}]



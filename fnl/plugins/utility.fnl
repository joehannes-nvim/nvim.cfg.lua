[[:editorconfig/editorconfig-vim]
 [:wakatime/vim-wakatime]
 [:chrisbra/unicode.vim]
 [:kkharji/sqlite.lua]
 {1 :junegunn/fzf :build (fn [] ((. vim.fn "fzf#install")))}
 {1 :roobert/hoversplit.nvim
  :config (fn []
            ((. (require :hoversplit) :setup) {}))}
 {1 :nvim-telescope/telescope-fzf-native.nvim
  :build "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"}
 {1 :nvim-telescope/telescope.nvim
  :config (fn [] (local config (require :plugins/config/telescope))
            (local neoclip (require :plugins/config/neoclip))
            (config.setup)
            (neoclip.setup))
  :dependencies [:nvim-lua/popup.nvim
                 :nvim-lua/plenary.nvim
                 :kkharji/sqlite.lua
                 :nvim-telescope/telescope-project.nvim
                 :nvim-telescope/telescope-smart-history.nvim
                 :nvim-telescope/telescope-frecency.nvim
                 :nvim-telescope/telescope-symbols.nvim
                 :nvim-telescope/telescope-node-modules.nvim
                 :nvim-telescope/telescope-github.nvim
                 :nvim-telescope/telescope-arecibo.nvim
                 :nvim-telescope/telescope-ui-select.nvim
                 :joehannes-os/telescope-media-files.nvim
                 :debugloop/telescope-undo.nvim
                 :sudormrfbin/cheatsheet.nvim
                 :AckslD/nvim-neoclip.lua
                 :Azeirah/nvim-redux
                 :tiagovla/scope.nvim]}
 {1 :kelly-lin/telescope-ag
  :config (fn []
            ((. (require :telescope-ag) :setup) {}))
  :dependencies :nvim-telescope/telescope.nvim}
 {1 :petertriho/nvim-scrollbar
  :config (fn []
            ((. (require :plugins.config.scrollbar) :setup)))}
 {1 :kevinhwang91/nvim-bqf
  :config (fn []
            ((. (require :plugins.config.bqf) :setup)))
  :dependencies [:fzf :nvim-treesitter :vim-grepper]}
 [:RRethy/vim-illuminate]
 {1 :abecodes/tabout.nvim
  :config (fn []
            ((. (require :tabout) :setup) {:act_as_shift_tab false
                                           :act_as_tab false
                                           :backwards_tabkey "<<"
                                           :completion false
                                           :enable_backwards true
                                           :exclude {}
                                           :ignore_beginning true
                                           :tabkey ">>"
                                           :tabouts [{:close "'" :open "'"}
                                                     {:close "\"" :open "\""}
                                                     {:close "`" :open "`"}
                                                     {:close ")" :open "("}
                                                     {:close "]" :open "["}
                                                     {:close "}" :open "{"}
                                                     {:close ">" :open "<"}]}))
  :dependencies [:nvim-cmp :nvim-treesitter]}
 [:smitajit/bufutils.vim]
 [:arithran/vim-delete-hidden-buffers]
 {1 :kazhala/close-buffers.nvim
  :config (fn []
            ((. (require :close_buffers) :setup) {:file_glob_ignore [:src/**/*]
                                                  :filetype_ignore [:qf]
                                                  :next_buffer_cmd (fn [windows]
                                                                     ((. (require :bufferline)
                                                                         :cycle) 1)
                                                                     (local bufnr
                                                                            (vim.api.nvim_get_current_buf))
                                                                     (each [_ window (ipairs windows)]
                                                                       (vim.api.nvim_win_set_buf window
                                                                                                 bufnr)))
                                                  :preserve_window_layout [:this
                                                                           :nameless]}))
  :dependencies [:akinsho/bufferline.nvim]}
 {1 :Krafi2/jeskape.nvim
  :config (fn []
            ((. (require :jeskape) :setup) {:mappings {:<Esc> :<cmd>stopinsert<cr>
                                                       :<leader> {:<leader> :<cmd>w<cr>}
                                                       :j {:k :<cmd>stopinsert<cr><cmd>w!<cr>}}
                                            :timeout vim.o.timeoutlen}))}
 {1 :HakonHarnes/img-clip.nvim
  :cmd :PasteImage
  :config (fn []
            ((. (require :plugins.config.pasteimg) :setup)))
  :keys [{1 :<leader>p 2 :<cmd>PasteImage<cr> :desc "Paste clipboard image"}]
  :opts {}}
 {1 :folke/which-key.nvim
  :config (fn []
            ((. (require :which-key) :setup) {:icons {:group ""}
                                              :layout {:height {:min 1 :max 25}
                                                       :width {:min 1 :max 25}
                                                       :align :center}
                                              :hidden [ "<silent>" "<cmd>" "<Cmd>" "^:" "^ " "^call " "^lua "]}))}]


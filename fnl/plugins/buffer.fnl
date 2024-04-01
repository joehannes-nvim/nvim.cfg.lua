(local my _G.my)

[; {1 :tiagovla/scope.nvim
 ; :config (fn []
 ;           ((. (require :scope) :setup))
 [:mildred/vim-bufmru]
 {1 :kwkarlwang/bufresize.nvim
  :config (fn []
            (local opts {:noremap true :silent true})
            ((. (require :bufresize) :setup) {:register {:keys [[:n
                                                                 :<leader>w<
                                                                 :30<C-w><
                                                                 opts]
                                                                [:n
                                                                 :<leader>w>
                                                                 :30<C-w>>
                                                                 opts]
                                                                [:n
                                                                 :<leader>w+
                                                                 :10<C-w>+
                                                                 opts]
                                                                [:n
                                                                 :<leader>w-
                                                                 :10<C-w>-
                                                                 opts]
                                                                [:n
                                                                 :<leader>w_
                                                                 :<C-w>_
                                                                 opts]
                                                                [:n
                                                                 :<leader>w=
                                                                 :<C-w>=
                                                                 opts]
                                                                [:n
                                                                 :<leader>w|
                                                                 :<C-w>|
                                                                 opts]
                                                                [:n
                                                                 :<leader>wo
                                                                 :<C-w>|<C-w>_
                                                                 opts]]
                                                         :trigger_events [:BufWinEnter
                                                                          :WinEnter]}
                                              :resize {:keys {}
                                                       :trigger_events [:VimResized]}}))}
 {1 :anuvyklack/windows.nvim
  :config (fn []
            (set vim.o.winwidth 12)
            (set vim.o.winminwidth 12)
            (set vim.o.winheight 20)
            (set vim.o.winminheight 1)
            (set vim.o.equalalways false)
            ((. (require :windows) :setup) {:ignore {:buftype [:quickfix]
                                                     :filetype [:NvimTree
                                                                :neo-tree
                                                                :undotree
                                                                :gundo
                                                                :Outline
                                                                :flutterToolsOutline
                                                                :Trouble
                                                                :DiffviewFiles]}}))
  :dependencies [:anuvyklack/middleclass :anuvyklack/animation.nvim]}
 {1 :danilamihailov/beacon.nvim
  :config (fn []
            (vim.api.nvim_set_var :beacon_enable true)
            (vim.api.nvim_set_var :beacon_size 80)
            (vim.api.nvim_set_var :beacon_minimal_jump 2)
            (vim.api.nvim_set_var :beacon_ignore_filetypes
                                  [:trouble :telescope :terminal :fzf])
            (vim.api.nvim_set_hl 0 :Beacon
                                 {:bg my.color.my.magenta
                                  :ctermbg :magenta}))}
 {1 :simrat39/symbols-outline.nvim
  :config (fn []
            ((. (require :plugins.config.symbols_outline) :setup)))}
 {1 :folke/trouble.nvim
  :config (fn []
            ((. (require :plugins.config.trouble) :setup)))
  :dependencies :kyazdani42/nvim-web-devicons}
 {1 :folke/zen-mode.nvim
  :config (fn []
            ((. (require :plugins.config.zen) :setup)))}
 {1 :folke/twilight.nvim
  :config (fn []
            ((. (require :twilight) :setup) {:context 21
                                             :dimming {:alpha 0.73
                                                       :inactive true}
                                             :exclude {}
                                             :expand [:function
                                                      :method
                                                      :table
                                                      :if_statement]
                                             :treesitter true}))}
 {1 :petertriho/nvim-scrollbar
  :config (fn []
            ((. (require :plugins.config.scrollbar) :setup)))}
 {1 :kevinhwang91/nvim-hlslens
  :config (fn []
            ((. (require :plugins.config.hlslens) :setup)))
  :dependencies [:petertriho/nvim-scrollbar]}]


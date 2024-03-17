(local my _G.my)

[{1 :themercorp/themer.lua
  :config (fn []
            ((. (require :plugins.config.themer) :setup)))}
 ; {1 :ray-x/starry.nvim
 ;  :config (fn []
 ;            ((. (require :plugins.config.starry) :setup)))}
 [:savq/melange]
 {1 :joehannes-ux/lush-jsx.nvim
  :config (fn []
            (set vim.g.lush_jsx_contrast_dark :hard)
            (set vim.g.lush_jsx_contrast_light :hard)
            ((. (require :lush_jsx) :setup) {:langs [:clojure
                                                     :css
                                                     :html
                                                     :js
                                                     :json
                                                     :jsx
                                                     :lua
                                                     :markdown
                                                     :python
                                                     :typescript
                                                     :viml
                                                     :xml]
                                             :plugins [:cmp
                                                       :gitsigns
                                                       :lsp
                                                       :lspsaga
                                                       :neogit
                                                       :telescope
                                                       :treesitter]}))}
 [:akai54/2077.nvim]
 [:Abstract-IDE/Abstract-cs]
 [:olimorris/onedarkpro.nvim]
 [:pineapplegiant/spaceduck]
 {:as :monokaipro
  :config (fn [] (set vim.g.monokaipro_filter :spectrum)
            (set vim.g.monokaipro_italic_functions true)
            (set vim.g.monokaipro_sidebars [:aerial])
            (set vim.g.monokaipro_flat_term true))
  :dir "https://gitlab.com/__tpb/monokai-pro.nvim"}
 [:pappasam/papercolor-theme-slim]
 {1 :catppuccin/nvim :as :catppuccin}
 [:joehannes-ux/kat.nvim]
 {1 :meijieru/edge.nvim :dependencies [:rktjmp/lush.nvim]}
 [:folke/tokyonight.nvim]
 [:B4mbus/oxocarbon-lua.nvim]
 {1 :f-person/auto-dark-mode.nvim
  :config (fn []
            (local auto-dark-mode (require :auto-dark-mode))
            (auto-dark-mode.setup {:set_dark_mode (fn []
                                                    (vim.api.nvim_set_option :background
                                                                             :dark))
                                   :set_light_mode (fn []
                                                     (vim.api.nvim_set_option :background
                                                                              :light))
                                   :update_interval 1000})
            (vim.schedule auto-dark-mode.init))}
 {1 :cpea2506/one_monokai.nvim
  :config (fn []
            ((. (require :one_monokai) :setup) {:colors {:blue my.color.my.aqua
                                                         :green my.color.my.green
                                                         :lmao (my.color.util.darken (my.color.util.desaturate my.color.my.purple
                                                                                                               50)
                                                                                     (or (and (= (vim.opt.background:get)
                                                                                                 :light)
                                                                                              0)
                                                                                         90))
                                                         :pink (my.color.util.desaturate my.color.my.magenta
                                                                                         50)
                                                         :roman my.color.my.magenta}
                                                :themes (fn [colors]
                                                          {:Comment {:fg colors.pink
                                                                     :italic true}
                                                           :ErrorMsg {:bg my.color.my.red
                                                                      :fg :black
                                                                      :standout true}
                                                           :Normal {:bg colors.lmao}
                                                           :NormalFloat {:link my.color.my.lmao}})
                                                :transparent true}))}
 [:theniceboy/nvim-deus]
 {1 :shaunsingh/moonlight.nvim
  :config (fn [] (set vim.g.moonlight_italic_comments true)
            (set vim.g.moonlight_italic_keywords true)
            (set vim.g.moonlight_italic_functions true)
            (set vim.g.moonlight_italic_variables false)
            (set vim.g.moonlight_contrast true)
            (set vim.g.moonlight_borders false)
            (set vim.g.moonlight_disable_background false))}
 {1 :yorik1984/newpaper.nvim :config true}
 {1 :ofirgall/ofirkai.nvim
  :config (fn []
            ((. (require :ofirkai) :setup) {}))}
 {1 :yashguptaz/calvera-dark.nvim
  :config (fn [] (set vim.g.calvera_italic_keywords true)
            (set vim.g.calvera_borders true)
            (set vim.g.calvera_contrast true)
            (set vim.g.calvera_hide_eob true)
            (set vim.g.calvera_custom_colors {:contrast "#0f111a"})
            (set vim.g.calvera_borders false)
            (set vim.g.calvera_disable_background false)
            (set vim.g.transparent_bg true))}
 {1 :marko-cerovac/material.nvim
  :config (fn []
            ((. (require :material) :setup) {:async_loading true
                                             :contrast {:cursor_line true
                                                        :filetypes {}
                                                        :floating_windows true
                                                        :non_current_windows true
                                                        :sidebars true
                                                        :terminal true}
                                             :custom_colors nil
                                             :custom_highlights {}
                                             :disable {:background false
                                                       :borders false
                                                       :colored_cursor false
                                                       :eob_lines false
                                                       :term_colors false}
                                             :high_visibility {:darker true
                                                               :lighter true}
                                             :lualine_style :default
                                             :plugins [:dap
                                                       :gitsigns
                                                       :hop
                                                       :indent-blankline
                                                       :neogit
                                                       :nvim-cmp
                                                       :nvim-navic
                                                       :nvim-web-devicons
                                                       :telescope
                                                       :trouble
                                                       :which-key]
                                             :styles {:comments {:italic true}
                                                      :functions {:bold true
                                                                  :italic true}
                                                      :keywords {:bold true}
                                                      :operators {:bold true}
                                                      :strings {}
                                                      :types {:italic true}
                                                      :variables {:italic true}}}))}
 [:sainnhe/sonokai]
 {1 :NLKNguyen/papercolor-theme
  :config (fn []
            (vim.cmd "        let g:PaperColor_Theme_Options = {
          \\   'theme': {
          \\     'default': {
          \\       'allow_bold': 1,
          \\       'allow_italic': 1
          \\     }
          \\   }
          \\ }
      "))}
 {1 :maxmx03/fluoromachine.nvim
  :config (fn []
            (local fm (require :fluoromachine))
            (fm.setup {:brightness 0.2
                       :colors (fn [_ d]
                                 {:alt_bg (d (. my.color.my.vimode
                                                (vim.fn.mode))
                                             75)
                                  :bg (. my.color.my (vim.opt.background:get))
                                  :cyan my.color.my.aqua
                                  :orange my.color.my.orange
                                  :pink my.color.my.magenta
                                  :purple my.color.my.purple
                                  :red my.color.my.red
                                  :yellow my.color.my.yellow})
                       :glow true
                       :overrides {"@comment" {:italic true}
                                   "@constant" {:bold true :italic false}
                                   "@field" {:italic true}
                                   "@function" {:bold true :italic true}
                                   "@keyword" {:bold true :italic false}
                                   "@parameter" {:italic true}
                                   "@type" {:bold false :italic true}
                                   "@variable" {:italic true}}
                       :theme :retrowave
                       :transparent false}))}]


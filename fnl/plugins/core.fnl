(local my _G.my)

[[:Olical/nfnl]
 {1 :folke/neodev.nvim
  :config (fn []
            ((. (require :neodev) :setup) {}))
  :opts {}}
 [:nvim-lua/plenary.nvim]
 [:stevearc/dressing.nvim]
 [:MunifTanjim/nui.nvim]
 {1 :rcarriga/nvim-notify
  :config (fn []
            ((. (require :plugins.config.notify) :setup)))
  :event :VimEnter}
 [:nvim-lua/popup.nvim]
 {1 :folke/edgy.nvim
  :event :VeryLazy
  :init (fn []
          (set vim.opt.laststatus 3)
          (set vim.opt.splitkeep :screen)) ; or :topline
  :opts {:keys {:<c-q> (fn [win] (win:hide))
                :<c-w>+ (fn [win] (win:resize :height 2))
                :<c-w>- (fn [win] (win:resize :height (- 2)))
                :<c-w><lt> (fn [win] (win:resize :width (- 2)))
                :<c-w>= (fn [win] (win.view.edgebar:equalize))
                :<c-w>> (fn [win] (win:resize :width 2))
                :Q (fn [win] (win.view.edgebar:close))
                "[W" (fn [win] (win:prev {:focus true :pinned false}))
                "[L" (fn [win] (win:prev {:focus true :visible true}))
                "]W" (fn [win] (win:next {:focus true :pinned false}))
                "]L" (fn [win] (win:next {:focus true :visible true}))
                :q (fn [win] (win:close))}
         :left [{:title "GitFiles"
                 :ft :sidebar-nvim
                 :pinned true
                 :open "SidebarNvimToggle"}
                {:title :FileTree
                 :ft :filetree
                 :open :NvimTreeToggle}]
         :right [{:title "OGPT Popup"
                  :ft "ogpt-popup"
                  :size {:width 0.2}
                  :wo {:wrap true}}
                 {:title "OGPT Parameters"
                  :ft "ogpt-parameters-window"
                  :size {:height 6}
                  :wo {:wrap true}}
                 {:title "OGPT Template"
                  :ft "ogpt-template"
                  :size {:height 6}}
                 {:title "OGPT Sesssions"
                  :ft "ogpt-sessions"
                  :size {:height 6}
                  :wo {:wrap true}}
                 {:title "OGPT System Input"
                  :ft "ogpt-system-window"
                  :size {:height 6}}
                 {:title "OGPT"
                  :ft "ogpt-window"
                  :size {:height 0.5}
                  :wo {:wrap true}}
                 {:title "OGPT {{selection}}"
                  :ft "ogpt-selection"
                  :size {:width 80
                         :height 4}
                  :wo {:wrap true}}
                 {:title "OGPt {{instruction}}"
                  :ft "ogpt-instruction"
                  :size {:width 80
                         :height 4}
                  :wo {:wrap true}}
                 {:title "OGPT Chat"
                  :ft "ogpt-input"
                  :size {:width 80
                         :height 4}
                  :wo {:wrap true}}]}}
 [:mbbill/undotree]
 {1 :nvim-neo-tree/neo-tree.nvim
  :branch :v3.x
  :config (fn []
            (vim.fn.sign_define :DiagnosticSignError
                                {:text " " :texthl :DiagnosticSignError})
            (vim.fn.sign_define :DiagnosticSignWarn
                                {:text " " :texthl :DiagnosticSignWarn})
            (vim.fn.sign_define :DiagnosticSignInfo
                                {:text " " :texthl :DiagnosticSignInfo})
            (vim.fn.sign_define :DiagnosticSignHint
                                {:text "󰌵" :texthl :DiagnosticSignHint})
            ((. (require :neo-tree) :setup) {:buffers {:follow_current_file {:enabled true
                                                                             :leave_dirs_open false}
                                                       :group_empty_dirs true
                                                       :show_unloaded true
                                                       :window {:mappings {:. :set_root
                                                                           :<bs> :navigate_up
                                                                           :bd :buffer_delete
                                                                           :o {1 :show_help
                                                                               :config {:prefix_key :o
                                                                                        :title "Order by"}
                                                                               :nowait false}
                                                                           :oc {1 :order_by_created
                                                                                :nowait false}
                                                                           :od {1 :order_by_diagnostics
                                                                                :nowait false}
                                                                           :om {1 :order_by_modified
                                                                                :nowait false}
                                                                           :on {1 :order_by_name
                                                                                :nowait false}
                                                                           :os {1 :order_by_size
                                                                                :nowait false}
                                                                           :ot {1 :order_by_type
                                                                                :nowait false}}}}
                                             :close_if_last_window false
                                             :commands {}
                                             :default_component_configs {:container {:enable_character_fade true}
                                                                         :created {:enabled true
                                                                                   :required_width 110}
                                                                         :file_size {:enabled true
                                                                                     :required_width 64}
                                                                         :git_status {:symbols {:added ""
                                                                                                :conflict ""
                                                                                                :deleted "✖"
                                                                                                :ignored ""
                                                                                                :modified ""
                                                                                                :renamed "󰁕"
                                                                                                :staged ""
                                                                                                :unstaged "󰄱"
                                                                                                :untracked ""}}
                                                                         :icon {:default "*"
                                                                                :folder_closed ""
                                                                                :folder_empty "󰜌"
                                                                                :folder_open ""
                                                                                :highlight :NeoTreeFileIcon}
                                                                         :indent {:expander_collapsed ""
                                                                                  :expander_expanded ""
                                                                                  :expander_highlight :NeoTreeExpander
                                                                                  :highlight :NeoTreeIndentMarker
                                                                                  :indent_marker "│"
                                                                                  :indent_size 2
                                                                                  :last_indent_marker "└"
                                                                                  :padding 1
                                                                                  :with_expanders nil
                                                                                  :with_markers true}
                                                                         :last_modified {:enabled true
                                                                                         :required_width 88}
                                                                         :modified {:highlight :NeoTreeModified
                                                                                    :symbol "[+]"}
                                                                         :name {:highlight :NeoTreeFileName
                                                                                :trailing_slash false
                                                                                :use_git_status_colors true}
                                                                         :symlink_target {:enabled false}
                                                                         :type {:enabled true
                                                                                :required_width 122}}
                                             :enable_diagnostics true
                                             :enable_git_status true
                                             :enable_normal_mode_for_inputs false
                                             :filesystem {:commands {}
                                                          :filtered_items {:always_show {}
                                                                           :hide_by_name {}
                                                                           :hide_by_pattern {}
                                                                           :hide_dotfiles false
                                                                           :hide_gitignored true
                                                                           :hide_hidden true
                                                                           :never_show {}
                                                                           :never_show_by_pattern {}
                                                                           :visible false}
                                                          :follow_current_file {:enabled true
                                                                                :leave_dirs_open true}
                                                          :group_empty_dirs false
                                                          :hijack_netrw_behavior :open_default
                                                          :use_libuv_file_watcher true
                                                          :window {:fuzzy_finder_mappings {:<C-j> :move_cursor_down
                                                                                           :<C-k> :move_cursor_up
                                                                                           :<down> :move_cursor_down
                                                                                           :<up> :move_cursor_up}
                                                                   :mappings {"#" :fuzzy_sorter
                                                                              :. :set_root
                                                                              :/ :fuzzy_finder
                                                                              :<bs> :navigate_up
                                                                              :<c-x> :clear_filter
                                                                              :D :fuzzy_finder_directory
                                                                              :H :toggle_hidden
                                                                              "[g" :prev_git_modified
                                                                              "]g" :next_git_modified
                                                                              :f :filter_on_submit
                                                                              :o {1 :show_help
                                                                                  :config {:prefix_key :o
                                                                                           :title "Order by"}
                                                                                  :nowait false}
                                                                              :oc {1 :order_by_created
                                                                                   :nowait false}
                                                                              :od {1 :order_by_diagnostics
                                                                                   :nowait false}
                                                                              :og {1 :order_by_git_status
                                                                                   :nowait false}
                                                                              :om {1 :order_by_modified
                                                                                   :nowait false}
                                                                              :on {1 :order_by_name
                                                                                   :nowait false}
                                                                              :os {1 :order_by_size
                                                                                   :nowait false}
                                                                              :ot {1 :order_by_type
                                                                                   :nowait false}}}}
                                             :git_status {:window {:mappings {:A :git_add_all
                                                                              :ga :git_add_file
                                                                              :gc :git_commit
                                                                              :gg :git_commit_and_push
                                                                              :gp :git_push
                                                                              :gr :git_revert_file
                                                                              :gu :git_unstage_file
                                                                              :o {1 :show_help
                                                                                  :config {:prefix_key :o
                                                                                           :title "Order by"}
                                                                                  :nowait false}
                                                                              :oc {1 :order_by_created
                                                                                   :nowait false}
                                                                              :od {1 :order_by_diagnostics
                                                                                   :nowait false}
                                                                              :om {1 :order_by_modified
                                                                                   :nowait false}
                                                                              :on {1 :order_by_name
                                                                                   :nowait false}
                                                                              :os {1 :order_by_size
                                                                                   :nowait false}
                                                                              :ot {1 :order_by_type
                                                                                   :nowait false}}
                                                                   :position :float}}
                                             :nesting_rules {}
                                             :open_files_do_not_replace_types [:terminal
                                                                               :trouble
                                                                               :qf]
                                             :popup_border_style :rounded
                                             :sort_case_insensitive false
                                             :sort_function nil
                                             :window {:mapping_options {:noremap true
                                                                        :nowait true}
                                                      :mappings {:< :prev_source
                                                                 :<2-LeftMouse> :open
                                                                 :<cr> :open
                                                                 :<esc> :cancel
                                                                 :<space> {1 :toggle_node
                                                                           :nowait false}
                                                                 :> :next_source
                                                                 :? :show_help
                                                                 :A :add_directory
                                                                 :C :close_node
                                                                 :P {1 :toggle_preview
                                                                     :config {:use_float true
                                                                              :use_image_nvim true}}
                                                                 :R :refresh
                                                                 :S :open_split
                                                                 :a {1 :add
                                                                     :config {:show_path :none}}
                                                                 :c :copy
                                                                 :d :delete
                                                                 :i :show_file_details
                                                                 :l :focus_preview
                                                                 :m :move
                                                                 :p :paste_from_clipboard
                                                                 :q :close_window
                                                                 :r :rename
                                                                 :s :open_vsplit
                                                                 :t :open_tabnew
                                                                 :w :open_with_window_picker
                                                                 :x :cut_to_clipboard
                                                                 :y :copy_to_clipboard
                                                                 :z :close_all_nodes}
                                                      :position :left
                                                      :width 37}}))
  :requires [:nvim-lua/plenary.nvim
             :nvim-tree/nvim-web-devicons
             :MunifTanjim/nui.nvim]}
 {1 :s1n7ax/nvim-window-picker
  :config (fn []
            ((. (require :window-picker) :setup) {:filter_rules {:autoselect_one true
                                                                 :bo {:buftype [:terminal
                                                                                :quickfix]
                                                                      :filetype [:neo-tree
                                                                                 :neo-tree-popup
                                                                                 :notify]}
                                                                 :include_current_win false}}))
  :version :2.*}
 {1 :joehannes-nvim/switchpanel.nvim
  :config (fn []
            ((. (require :switchpanel) :setup) {:builtin [:neotree-files :neotree-gitstatus :neotree-buffers :undotree]
                                                :focus_on_open true
                                                :panel_list {:background :Silver :color :Black :selected :Gold :show false}
                                                :tab_repeat true
                                                :width 30}))}
 {1 :luukvbaal/statuscol.nvim
  :config (fn []
            ((. (require :plugins.config.statuscol) :setup)))}
 [:nathom/filetype.nvim]
 {1 :olimorris/persisted.nvim
  :config (fn []
            ((. (require :persisted) :setup) {:allowed_dirs nil
                                              :autoload false
                                              :autosave true
                                              :follow_cwd true
                                              :ignored_dirs nil
                                              :on_autoload_no_session (fn [])
                                              :save_dir (vim.fn.expand (.. (vim.fn.stdpath :data)
                                                                           :/sessions/))
                                              :should_autosave nil
                                              :silent true
                                              :telescope {:reset_prompt_after_deletion true}
                                              :use_git_branch true}))}
 [:tversteeg/registers.nvim]
 ; crashing my nvim as of bleeding edge build on 12. March 2024
 ; [:kevinhwang91/promise-async]
 ; {1 :kevinhwang91/nvim-ufo
 ;  :config (fn []
 ;            ((. (require :plugins.config.ufo) :setup)))
 ;  :dependencies :kevinhwang91/promise-async}
 {1 :anuvyklack/pretty-fold.nvim
  :config #((. (require :pretty-fold) :setup))}
 {1 :folke/noice.nvim
  :event :VeryLazy
  :opts {}
  :dependencies ["MunifTanjim/nui.nvim" "rcarriga/nvim-notify"]
  :config #((. (require :plugins.config.noice) :setup))}
  ; {1 :gelguy/wilder.nvim
  ;  :config (fn []
  ;            ((. (require :plugins.config.wilder) :setup)))}
 [:indianboy42/hop-extensions]
 {1 :karb94/neoscroll.nvim
  :config (fn []
            ((. (require :plugins.config.scroll) :setup)))}
 {1 :akinsho/toggleterm.nvim
  :config (fn []
            ((. (require :toggleterm) :setup) {:auto_scroll true
                                               :autochdir true
                                               :close_on_exit true
                                               :direction :horizontal
                                               :float_opts {:border :curved
                                                            :height (math.ceil (* vim.o.lines 0.9))
                                                            :width vim.o.columns
                                                            :winblend 5}
                                               :hide_numbers true
                                               :highlights {:FloatBorder {:guibg :NONE
                                                                                                           :guifg my.color.my.magenta
                                                                                             :Normal {:guibg ((. (my.color.hsl (. my.color.my
                                                                                                                                  (vim.opt.background:get)))
                                                                                                                 :mix) (my.color.hsl (. my.color.my.vimode
                                                                                                                                                                                                                                                                                                                                                                                 (or (vim.fn.mode)
                                                                                                                                                                                                                                                                                                                                                                                     :n)))
                                                                                                                       21)}
                                                                                             :NormalFloat {:link :Normal}
                                                                                :insert_mappings true
                                                                                :on_exit (fn [t]
                                                                                           (my.ui.removeTerminal t))
                                                                                :on_open (fn [t]
                                                                                           (my.ui.addTerminal t)
                                                                                           (vim.cmd :startinsert!))
                                                                                :persist_mode true
                                                                                :persist_size true
                                                                                :shade_filetypes {}
                                                                                :shade_terminals true
                                                                                :shading_factor (- 21)
                                                                                :shell vim.o.shell
                                                                                :size (fn [term]
                                                                                        (if (= term.direction
                                                                                               :horizontal)
                                                                                            17
                                                                                            (= term.direction
                                                                                               :vertical)
                                                                                            (* vim.o.columns 0.4)))
                                                                                :start_in_insert true
                                                                                :terminal_mappings true
                                                                                :winbar {:enabled true
                                                                                         :name_formatter (fn [term]
                                                                                                           term.name)}}}}))}
 {1 :rolv-apneseth/tfm.nvim
  :lazy false
  :opts {:file_manager "yazi"
         :replace_netrw true
         :enable_cmds true
         :keybindings {:<ESC> "q"}
         :ui {:border "rounded"
              :height 0.9
              :width 1
              :x 0
              :y 0}}}
 {1 :lukas-reineke/indent-blankline.nvim :main :ibl :opts {}}
 {1 :mrshmllow/document-color.nvim
  :config (fn []
            ((. (require :document-color) :setup) {:mode :background}))}
 [:mhinz/vim-grepper]
 {1 :ahmedkhalf/project.nvim
  :config (fn []
            ((. (require :project_nvim) :setup) {:detection_methods [:pattern]}))}
 {1 :danymat/neogen
  :config (fn []
            ((. (require :neogen) :setup) {:enabled true
                                           :input_after_comment true
                                           :languages {:javascript {:template {:annotation_convention :jsdoc}}
                                                       :javascriptreact {:template {:annotation_convention :jsdoc}}
                                                       :typescript {:template {:annotation_convention :tsdoc}}
                                                       :typescriptreact {:template {:annotation_convention :tsdoc}}}}))
  :dependencies :nvim-treesitter/nvim-treesitter}]

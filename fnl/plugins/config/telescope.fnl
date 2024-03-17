(local config {})

(fn config.setup []
  (let [trouble (require :trouble.providers.telescope)
        telescope (require :telescope)
        actions (require :telescope.actions)]
    (telescope.setup {:defaults {:history {:limit 100
                                           :path (.. (vim.fn.stdpath :data)
                                                     :/databases/telescope_history.sqlite3)}
                                 :initial_mode :insert
                                 :mappings {:i {:<c-l> trouble.open_with_trouble
                                                :<c-q> actions.smart_send_to_qflist}
                                            :n {:<c-l> trouble.open_with_trouble
                                                :<c-q> actions.smart_send_to_qflist}}
                                 :path_display {:truncate 1}
                                 :preview {:mime_hook (fn [filepath bufnr opts]
                                                        (fn is-image [filepath]
                                                          (local image-extensions
                                                                 [:png
                                                                  :jpg
                                                                  :jpeg
                                                                  :gif])
                                                          (local split-path
                                                                 (vim.split (filepath:lower)
                                                                            "."
                                                                            {:plain true}))
                                                          (local extension
                                                                 (. split-path
                                                                    (length split-path)))
                                                          (vim.tbl_contains image-extensions
                                                                            extension))

                                                        (if (is-image filepath)
                                                            (do
                                                              (local term
                                                                     (vim.api.nvim_open_term bufnr
                                                                                             {}))
                                                              (fn send-output [_
                                                                               data
                                                                               _]
                                                                (each [_ d (ipairs data)]
                                                                  (vim.api.nvim_chan_send term
                                                                                          (.. d
                                                                                              "\r
"))))

                                                              (vim.fn.jobstart [:viu
                                                                                filepath]
                                                                               {:on_stdout send-output
                                                                                :stdout_buffered true}))
                                                            ((. (require :telescope.previewers.utils)
                                                                :set_preview_message) bufnr
                                                                                                                                                                                            opts.winid
                                                                                                                                                                                            "Binary cannot be previewed")))}}
                      :extensions {:arecibo {:selected_engine :google
                                             :show_domain_icons false
                                             :show_http_headers false
                                             :url_open_command :open}
                                   :dash {:dash_app_path :/Applications/Dash.app
                                          :debounce 300
                                          :file_type_keywords {:NvimTree false
                                                               :TelescopePrompt true
                                                               :clojure [:clojure
                                                                         :clj
                                                                         :javascript
                                                                         :html
                                                                         :svg
                                                                         :css]
                                                               :dashboard false
                                                               :fzf false
                                                               :javascript [:javascript
                                                                            :html
                                                                            :svg
                                                                            :nodejs
                                                                            :css
                                                                            :sass
                                                                            :react]
                                                               :javascriptreact [:javascript
                                                                                 :html
                                                                                 :svg
                                                                                 :nodejs
                                                                                 :css
                                                                                 :sass
                                                                                 :react]
                                                               :lua [:lua
                                                                     :Neovim]
                                                               :packer true
                                                               :terminal true
                                                               :typescript [:typescript
                                                                            :javascript
                                                                            :nodejs
                                                                            :html
                                                                            :svg
                                                                            :nodejs
                                                                            :css
                                                                            :sass]
                                                               :typescriptreact [:typescript
                                                                                 :javascript
                                                                                 :html
                                                                                 :svg
                                                                                 :nodejs
                                                                                 :css
                                                                                 :sass
                                                                                 :react]}
                                          :search_engine :google}
                                   :frecency {:db_root (.. (vim.fn.stdpath :data)
                                                           :/databases)
                                              :disable_devicons false
                                              :ignore_patterns [:*.git/*
                                                                :*/tmp/*]
                                              :show_scores false
                                              :show_unindexed true
                                              :workspaces {:conf (.. (vim.fn.expand :$HOME)
                                                                     :/.config)
                                                           :data (.. (vim.fn.expand :$HOME)
                                                                     :/.local/share)
                                                           :orb (.. (vim.fn.expand :$HOME)
                                                                    :/.local/git/orbital)
                                                           :project (.. (vim.fn.expand :$HOME)
                                                                        :./.local/git)
                                                           :wiki (.. (vim.fn.expand :$HOME)
                                                                     :/wiki)}}
                                   :fzf {:case_mode :smart_case
                                         :fuzzy true
                                         :override_file_sorter true
                                         :override_generic_sorter true}
                                   :media_files {:filetypes [:png
                                                             :webp
                                                             :jpg
                                                             :jpeg
                                                             :mp4
                                                             :webm
                                                             :pdf]
                                                 :find_cmd :rg}
                                   :persisted {:layout_config {:height 0.7
                                                               :width 0.7}}
                                   :project {:base_dirs [{:path "~/.config/nvim"}
                                                         {:max_depth 3
                                                          :path "~/.local/git"}]
                                             :hidden_files true
                                             :on_project_selected (fn [prompt-bufnr]
                                                                    ((. (require :telescope._extensions.project.actions)
                                                                        :change_working_directory) prompt-bufnr
                                                                                                                                                                                                                            false))}
                                   :ui-select [((. (require :telescope.themes)
                                                   :get_dropdown) {})]
                                   :undo {:layout_config {:preview_height 0.8}
                                          :layout_strategy :vertical
                                          :side_by_side true}}
                      :file_previewer (. (require :telescope.previewers)
                                         :vim_buffer_cat :new)
                      :grep_previewer (. (require :telescope.previewers)
                                         :vim_buffer_vimgrep :new)
                      :pickers {:buffers {:theme :dropdown}
                                :find_files {:hidden true :theme :dropdown}
                                :git_branches {:theme :dropdown}
                                :git_commits {:mappings {:i {:<CR> (fn [prompt-bufnr]
                                                                     (actions.close prompt-bufnr)
                                                                     (local value
                                                                            (. (actions.get_selected_entry prompt-bufnr)
                                                                               :value))
                                                                     (vim.cmd (.. "DiffviewOpen "
                                                                                  value
                                                                                  "~1.."
                                                                                  value)))}}}
                                :lsp_code_actions {:theme :cursor}
                                :lsp_range_code_actions {:theme :cursor}
                                :oldfiles {:theme :dropdown}
                                :spell_suggest {:theme :cursor}
                                :colorscheme {:enable_preview true}}
                      :qflist_previewer (. (require :telescope.previewers)
                                           :vim_buffer_qflist :new)
                      :use_less true})
    (telescope.load_extension :fzf)
    (telescope.load_extension :gh)
    (telescope.load_extension :node_modules)
    (telescope.load_extension :project)
    (telescope.load_extension :neoclip)
    (telescope.load_extension :smart_history)
    (telescope.load_extension :arecibo)
    (telescope.load_extension :media_files)
    (telescope.load_extension :frecency)
    (telescope.load_extension :ui-select)
    (telescope.load_extension :undo)
    (telescope.load_extension :ag)
    (telescope.load_extension :persisted)
    (telescope.load_extension :scope)))

config


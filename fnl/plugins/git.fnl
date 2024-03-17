[{1 :lewis6991/gitsigns.nvim
  :config (fn []
            ((. (require :plugins.config.gitsigns) :setup)))
  :dependencies [:nvim-lua/plenary.nvim]}
 [:tpope/vim-fugitive]
 {1 :sindrets/diffview.nvim
  :config (fn []
            ((. (require :plugins.config.diffview) :setup)))}
 {1 :NeogitOrg/neogit
  :config (fn []
            ((. (require :neogit) :setup) {:integrations {:diffview true}}))
  :dependencies [:nvim-lua/plenary.nvim :nvim-telescope/telescope.nvim]}
 {1 :akinsho/git-conflict.nvim
  :config (fn []
            ((. (require :git-conflict) :setup) {:default_mappings true
                                                 :disable_diagnostics true
                                                 :highlights {:current :DiffAdd
                                                              :incoming :DiffText}})
            (vim.api.nvim_create_autocmd :User
                                         {:callback (fn []
                                                      (vim.notify (.. "Conflict detected in "
                                                                      (vim.fn.expand :<afile>))))
                                          :pattern :GitConflictDetected}))}
 {1 :ruifm/gitlinker.nvim
  :config (fn []
            ((. (require :gitlinker) :setup) {:callbacks {:bitbucket.org (. (require :gitlinker.hosts)
                                                                            :get_bitbucket_type_url)
                                                          :codeberg.org (. (require :gitlinker.hosts)
                                                                           :get_gitea_type_url)
                                                          :git.kernel.org (. (require :gitlinker.hosts)
                                                                             :get_cgit_type_url)
                                                          :git.launchpad.net (. (require :gitlinker.hosts)
                                                                                :get_launchpad_type_url)
                                                          :git.savannah.gnu.org (. (require :gitlinker.hosts)
                                                                                   :get_cgit_type_url)
                                                          :git.sr.ht (. (require :gitlinker.hosts)
                                                                        :get_srht_type_url)
                                                          :github.com (. (require :gitlinker.hosts)
                                                                         :get_github_type_url)
                                                          :gitlab.com (. (require :gitlinker.hosts)
                                                                         :get_gitlab_type_url)
                                                          :repo.or.cz (. (require :gitlinker.hosts)
                                                                         :get_repoorcz_type_url)
                                                          :try.gitea.io (. (require :gitlinker.hosts)
                                                                           :get_gitea_type_url)
                                                          :try.gogs.io (. (require :gitlinker.hosts)
                                                                          :get_gogs_type_url)}
                                              :opts {:action_callback (. (require :gitlinker.actions)
                                                                         :copy_to_clipboard)
                                                     :add_current_line_on_normal_mode true
                                                     :print_url true
                                                     :remote nil}}))
  :dependencies :nvim-lua/plenary.nvim}]


(local vim-vars (require :settings.variables))

(local vim-options (require :settings.options))

(local vim-aucmds (require :settings.aucmds))

(local vim-settings (require :settings.settings))

(each [key value (pairs vim-vars)] (vim.api.nvim_set_var key value))

(each [key value (pairs vim-options)] (vim.api.nvim_set_option key value))

(vim.opt.listchars:append "eol:↴")

(vim.cmd vim-settings)

(each [group-id group-v (pairs vim-aucmds)]
  (local group (vim.api.nvim_create_augroup group-id {:clear true}))
  (fn aucmd! [_group events pattern _callback]
    (vim.api.nvim_create_autocmd events
                                 {:callback _callback
                                  : group
                                  :pattern pattern}))
  (each [events cmds (pairs group-v)]
    (when (or (not= cmds.pattern nil) (not= cmds.callback nil))
      (each [_ ev (ipairs events)]
        (aucmd! group-id ev cmds.pattern cmds.callback)))))


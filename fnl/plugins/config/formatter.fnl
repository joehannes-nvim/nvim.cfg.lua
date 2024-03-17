(local M {})

(local defaults (require :formatter.defaults))

(local util (require :formatter.util))

(fn M.setup []
  (fn stylua []
    {:args [(vim.api.nvim_buf_get_name 0)] :exe :stylua :stdin false})

  (local ts (require :formatter.filetypes.typescript))
  (local tsx (require :formatter.filetypes.typescriptreact))
  ((. (require :formatter) :setup) {:filetype {:javascript (require :formatter.filetypes.javascript)
                                               :javascriptreact (require :formatter.filetypes.javascriptreact)
                                               :lua [stylua]
                                               :typescript ts
                                               :typescriptreact [tsx.prettierd
                                                                 tsx.prettiereslint
                                                                 tsx.eslint_d
                                                                 tsx.prettier]}}))

M


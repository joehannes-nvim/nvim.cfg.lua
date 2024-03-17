(local opts {:tokyonight_italic_functions true
             :tokyonight_sidebars [:qf
                                   :vista_kind
                                   :terminal
                                   :packer
                                   :symbols_outline
                                   :aerial
                                   :trouble]
             :tokyonight_style :night})

(each [key value (pairs opts)] (vim.api.nvim_set_var key value))


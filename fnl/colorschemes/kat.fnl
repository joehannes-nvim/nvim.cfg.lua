(local opts {:kat_nvim_commentStyle :italic
             :kat_nvim_integrations [:lsp :treesitter :ts_rainbow :cmp]
             :kat_nvim_stupidFeatures true})

(each [key value (pairs opts)] (vim.api.nvim_set_var key value))


(local opts {:neon_bold true
             :neon_italic_functions true
             :neon_italic_keyword true
             :neon_italic_variable true
             :neon_style :dark
             :neon_transparent false})

(each [key value (pairs opts)] (vim.api.nvim_set_var key value))


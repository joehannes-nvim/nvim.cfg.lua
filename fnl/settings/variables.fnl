(local my _G.my)

(local M {:Powerline_symbols :fancy
          :asyncrun_open 6
          :asynctasks_profile :npm
          :floaterm_height 0.9
          :floaterm_width 1
          :floaterm_winblend 5
          :floaterm_wintype :floating
          :neoranger_opts "--cmd=\"set show_hidden true\""
          :neoranger_viewmode :miller
          :neovide_cursor_vfx_mode :railgun
          :neovide_floating_blur_amount_x 3
          :neovide_floating_blur_amount_y 3
          :neovide_remember_window_size true
          :neovide_transparency 0.9
          :parinfer_force_balance false
          :parinfer_mode :smart
          :python3_host_prog (my.fs.path.python3:gsub "%s+" "")
          :python_host_prog (my.fs.path.python2:gsub "%s+" "")
          :qs_highlight_on_keys [:f :F :t :T]
          :transparency 0.5})

M


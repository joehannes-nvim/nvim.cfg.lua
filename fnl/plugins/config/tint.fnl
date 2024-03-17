(local M {})

(fn M.setup []
  (let [tint (require :tint)
        transforms (require :tint.transforms)]
    (tint.setup {:highlight_ignore_patterns [:WinSeparator
                                             :StatusLine
                                             :StatusLineNC
                                             :WinBar
                                             :Trouble
                                             :Nofile
                                             :nofile
                                             :Outline
                                             :SymbolsOutline
                                             :WinBarNC
                                             :HeirLine]
                 :saturation 0.7
                 :tint (or (and (= (vim.opt.background:get) :light) 21) (- 21))
                 :tint_background_colors true
                 :transforms [(transforms.saturate 0.7)]
                 :window_ignore_function (fn [winid]
                                           (local bufid
                                                  (vim.api.nvim_win_get_buf winid))
                                           (local buftype
                                                  (vim.api.nvim_buf_get_option bufid
                                                                               :buftype))
                                           (local floating
                                                  (not= (. (vim.api.nvim_win_get_config winid)
                                                           :relative)
                                                        ""))
                                           (or (or (= buftype :terminal)
                                                   (= buftype :nofile))
                                               floating))})))

M


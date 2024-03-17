(local M {})

(vim.cmd "autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()")

(fn M.setup []
  ((. (require :nvim-lightbulb) :update_lightbulb) {:float {:enabled false
                                                            :text "☼"
                                                            :win_opts {}}
                                                    :sign {:enabled true
                                                           :priority 20
                                                           :text "☼"}
                                                    :virtual_text {:enabled true
                                                                   :text "☼"}}))

M


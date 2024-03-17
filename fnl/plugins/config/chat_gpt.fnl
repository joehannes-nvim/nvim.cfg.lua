(local M {})

(local home (vim.fn.expand :$HOME))

(fn M.setup []
  ((. (require :chatgpt) :setup) {:api_key_cmd (.. "cat " home
                                                   :/.local/git/joehannes-os/safe/chatgpt.txt)}))

M


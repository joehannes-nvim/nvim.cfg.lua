(local M {})

(fn M.which [executable]
  (if (= jit.os :Windows) (vim.fn.system [(.. "(gcm " executable ").Source")])
      (: (vim.fn.system [:which executable]) :gsub "%\n$" "")))

(set M.path_sep (or (and (= jit.os :Windows) "\\") "/"))

(set M.dir {:cache (vim.fn.stdpath :cache)
            :cfg (vim.fn.stdpath :config)
            :data (vim.fn.stdpath :data)
            :home (vim.fn.getenv :HOME)
            :plugins (.. (vim.fn.stdpath :config) M.path_sep :site M.path_sep
                         :pack M.path_sep)})

(set M.path {:node (M.which :neovim-node-host)
             :python (M.which :python3)
             :python2 (M.which :python2)
             :python3 (M.which :python3)})

(fn M.exists [file-or-dir]
  (when (or (= file-or-dir "") (= file-or-dir nil)) (lua "return false"))
  (local (ok err code) (vim.fn.rename file-or-dir file-or-dir))
  (when (not ok) (when (= code 13) (lua "return true")))
  (values ok err))

(fn M.isdir [path]
  (when (or (= path "") (= path nil)) (lua "return false"))
  (M.exists (.. path "/")))

M


(tset (require :snippets) :snippets
      {:_global {:todo "TODO: "
                 :uname (fn [] (. (vim.loop.os_uname) :sysname))}})


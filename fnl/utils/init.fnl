(require :utils.vimscript)

(set _G.my {:astro {}
            :color (require :utils.color)
            :fn (require :utils.aucmd)
            :fs (require :utils.fs)
            :git (require :utils.git)
            :icon (require :utils.icons)
            :io (require :utils.io)
            :platform {:is_linux (= jit.os :Linux)
                       :is_mac (= jit.os :OSX)
                       :is_windows (= jit.os :Windows)}
            :struc (require :utils.table)
            :ui (require :utils.ui)})

(require :astro.bootstrap)

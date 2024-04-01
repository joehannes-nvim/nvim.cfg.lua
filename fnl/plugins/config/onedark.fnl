(local onedark (require :onedark))

(local c ((. (require :onedark.colors) :load)))

(onedark.setup {:options {:highlight_cursorline true}
                :styles {:comments :NONE
                         :functions :italic
                         :keywords "bold,italic"
                         :strings :NONE
                         :variables :italic}})


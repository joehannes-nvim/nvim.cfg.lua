(local onedark (require :onedark))

(local c ((. (require :onedark.colors) :load)))

(onedark.setup {:colors {:cursorline "#777777"}
                :hlgroups {:CursorColumn {:bg "#333333"}
                           :CursorLine {:bg "#333333"}
                           :TabLineFill {:bg c.purple :fg c.cyan}
                           :Tabline {:bg c.blue :fg c.gray}
                           :TablineSel {:bg c.purple :fg c.white}}
                :options {:highlight_cursorline true}
                :styles {:comments :NONE
                         :functions :italic
                         :keywords "bold,italic"
                         :strings :NONE
                         :variables :italic}})


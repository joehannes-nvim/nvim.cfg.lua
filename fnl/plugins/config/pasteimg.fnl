(local M {})

(fn M.setup []
  (let [opts {:asciidoc {:template "image::$FILE_PATH[width=80%, alt=\"$CURSOR\"]"}
              :dir_path :public/assets/img/
              :file_name "%Y-%m-%d-%H-%M-%S"
              :html {:template "<img src=\"$FILE_PATH\" alt=\"$CURSOR\">"}
              :insert_mode_after_paste false
              :jsx {:template "<img src=\"$FILE_PATH\" alt=\"$CURSOR\">"}
              :markdown {:template "![$CURSOR]($FILE_PATH)"
                         :url_encode_path true}
              :org {:template "#+BEGIN_FIGURE
[[file:$FILE_PATH]]
#+CAPTION: $CURSOR
#+NAME: fig:$LABEL
#+END_FIGURE
    "}
              :prompt_for_file_name true
              :relative_to_current_file false
              :rst {:template ".. image:: $FILE_PATH
   :alt: $CURSOR
   :width: 80%
    "}
              :show_dir_path_in_prompt true
              :template :$FILE_PATH
              :tex {:template "\\begin{figure}[h]
  \\centering
  \\includegraphics[width=0.8\\textwidth]{$FILE_PATH}
  \\caption{$CURSOR}
  \\label{fig:$LABEL}
\\end{figure}
    "}
              :tsx {:template "<img src=\"$FILE_PATH\" alt=\"$CURSOR\">"}
              :typst {:template "#figure(
  image(\"$FILE_PATH\", width: 80%),
  caption: [$CURSOR],
) <fig-$LABEL>
    "}
              :url_encode_path false
              :use_absolute_path false
              :use_cursor_in_template true}]
    ((. (require :img-clip) :setup) opts)))

M


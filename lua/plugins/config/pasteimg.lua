-- [nfnl] Compiled from fnl/plugins/config/pasteimg.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local opts = {asciidoc = {template = "image::$FILE_PATH[width=80%, alt=\"$CURSOR\"]"}, dir_path = "public/assets/img/", file_name = "%Y-%m-%d-%H-%M-%S", html = {template = "<img src=\"$FILE_PATH\" alt=\"$CURSOR\">"}, jsx = {template = "<img src=\"$FILE_PATH\" alt=\"$CURSOR\">"}, markdown = {template = "![$CURSOR]($FILE_PATH)", url_encode_path = true}, org = {template = "#+BEGIN_FIGURE\n[[file:$FILE_PATH]]\n#+CAPTION: $CURSOR\n#+NAME: fig:$LABEL\n#+END_FIGURE\n    "}, prompt_for_file_name = true, rst = {template = ".. image:: $FILE_PATH\n   :alt: $CURSOR\n   :width: 80%\n    "}, show_dir_path_in_prompt = true, template = "$FILE_PATH", tex = {template = "\\begin{figure}[h]\n  \\centering\n  \\includegraphics[width=0.8\\textwidth]{$FILE_PATH}\n  \\caption{$CURSOR}\n  \\label{fig:$LABEL}\n\\end{figure}\n    "}, tsx = {template = "<img src=\"$FILE_PATH\" alt=\"$CURSOR\">"}, typst = {template = "#figure(\n  image(\"$FILE_PATH\", width: 80%),\n  caption: [$CURSOR],\n) <fig-$LABEL>\n    "}, use_cursor_in_template = true, url_encode_path = false, use_absolute_path = false, relative_to_current_file = false, insert_mode_after_paste = false}
  return (require("img-clip")).setup(opts)
end
return M

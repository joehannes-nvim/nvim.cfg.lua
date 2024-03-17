(local M {})

(fn M.setup []
  ((. (require :noice) :setup) {:lsp {:override {:cmp.entry.get_documentation true}
                                                :vim.lsp.util.convert_input_to_markdown_lines true
                                                :vim.lsp.util.stylize_markdown true}
                                :messages {:enabled false
                                           :view :notify
                                           :view_error :notify
                                           :view_history :messages
                                           :view_search :virtualtext
                                           :view_warn :notify}
                                :presets {:bottom_search true
                                          :command_palette true
                                          :inc_rename true
                                          :long_message_to_split true
                                          :lsp_doc_border true}}))

M


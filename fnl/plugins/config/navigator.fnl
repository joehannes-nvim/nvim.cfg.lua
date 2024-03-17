((. (require :navigator) :setup) {:default_mapping true
                                  :icons {:code_action_icon ""
                                          :code_lens_action_icon ""
                                          :diagnostic_err ""
                                          :diagnostic_file ""
                                          :diagnostic_head ""
                                          :diagnostic_head_description "瘟"
                                          :diagnostic_head_severity_1 ""
                                          :diagnostic_head_severity_2 ""
                                          :diagnostic_head_severity_3 ""
                                          :diagnostic_hint "﯂"
                                          :diagnostic_info ""
                                          :diagnostic_virtual_text ""
                                          :diagnostic_warn ""
                                          :icons true
                                          :match_kinds {:associated "&"
                                                        :field "﫻"
                                                        :function " "
                                                        :method "ƒ "
                                                        :namespace " "
                                                        :parameter "  "
                                                        :type " "
                                                        :var " "}
                                          :treesitter_default ""
                                          :value_changed "פֿ"
                                          :value_definition ""}
                                  :keymaps [{:func "references()" :key :gr}
                                            {:func "references()"
                                             :key :<C-RightMouse>}
                                            {:func "signature_help()"
                                             :key :<M-k>
                                             :mode :i}
                                            {:func "signature_help()"
                                             :key :<c-k>}
                                            {:func "hover({ popup_opts = { border = single, max_width = 80 }})"
                                             :key :K}
                                            {:func "document_symbol()"
                                             :key :g$.}
                                            {:func "workspace_symbol()"
                                             :key :g$*}
                                            {:func "definition()" :key :gd}
                                            {:func "definition()"
                                             :key :<C-LeftMouse>}
                                            {:func "declaration({ border = 'rounded', max_width = 80 })"
                                             :key :gD}
                                            {:func "require('navigator.definition').definition_preview()"
                                             :key :gP}
                                            {:func "require('navigator.treesitter').buf_ts()"
                                             :key :gT}
                                            {:func "require('navigator.codeAction').code_action()"
                                             :key :ga
                                             :mode :n}
                                            {:func "range_code_action()"
                                             :key :ga
                                             :mode :v}
                                            {:func "require('navigator.codelens').run_action()"
                                             :key :gA
                                             :mode :n}
                                            {:func "rename()" :key :gR}
                                            {:func "incoming_calls()" :key :gI}
                                            {:func "outgoing_calls()" :key :gO}
                                            {:func "implementation()" :key :gi}
                                            {:func "implementation()"
                                             :key :<M-LeftMouse>}
                                            {:func "type_definition()"
                                             :key "g:"}
                                            {:func "require('navigator.diagnostics').show_line_diagnostics()"
                                             :key :gl.}
                                            {:func "require('navigator.diagnostics').show_diagnostic()"
                                             :key :gl*}
                                            {:func "diagnostic.goto_next({ border = 'rounded', max_width = 80})"
                                             :key "]d"}
                                            {:func "diagnostic.goto_prev({ border = 'rounded', max_width = 80})"
                                             :key "[d"}
                                            {:func "require('navigator.treesitter').goto_next_usage()"
                                             :key "]r"}
                                            {:func "require('navigator.treesitter').goto_previous_usage()"
                                             :key "[r"}
                                            {:func "require('navigator.dochighlight').hi_symbol()"
                                             :key :g/}
                                            {:func "add_workspace_folder()"
                                             :key :<space>>p}
                                            {:func "remove_workspace_folder()"
                                             :key :<Space><p}
                                            {:func "formatting()"
                                             :key :<Space>rf
                                             :mode :n}
                                            {:func "range_formatting()"
                                             :key :<Space>rf
                                             :mode :v}
                                            {:func "require('navigator.rename').rename()"
                                             :key :<Space>rr}
                                            {:func "print(vim.inspect(vim.lsp.buf.list_workspace_folders()))"
                                             :key :<Space>pl}]
                                  :lspinstall true
                                  :width 1})


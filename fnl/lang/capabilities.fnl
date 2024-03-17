(local capabilities
       ((. (require :cmp_nvim_lsp) :default_capabilities) (vim.lsp.protocol.make_client_capabilities)))

(set capabilities.textDocument.completion.completionItem.snippetSupport true)

(set capabilities.textDocument.completion.completionItem.preselectSupport true)

(set capabilities.textDocument.completion.completionItem.insertReplaceSupport
     true)

(set capabilities.textDocument.completion.completionItem.labelDetailsSupport
     true)

(set capabilities.textDocument.completion.completionItem.deprecatedSupport true)

(set capabilities.textDocument.completion.completionItem.commitCharactersSupport
     true)

(set capabilities.textDocument.completion.completionItem.tagSupport
     {:valueSet [1]})

(set capabilities.textDocument.completion.completionItem.resolveSupport
     {:properties [:documentation :detail :additionalTextEdits]})

(set capabilities.textDocument.codeAction
     {:codeActionLiteralSupport {:codeActionKind {:valueSet [""
                                                             :quickfix
                                                             :refactor
                                                             :refactor.extract
                                                             :refactor.inline
                                                             :refactor.rewrite
                                                             :source
                                                             :source.organizeImports]}}
      :dynamicRegistration true})

capabilities


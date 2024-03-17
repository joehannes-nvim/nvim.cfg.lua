(local on-attach {})

(fn on-attach.minimal [client bufnr]
  (vim.api.nvim_buf_set_option bufnr :omnifunc "v:lua.vim.lsp.omnifunc"))

(fn on-attach.generic [client bufnr]
  (on-attach.minimal client bufnr)
  ((. (require :nvim-navic) :attach) client bufnr)
  (when client.server_capabilities.document_highlight
    (vim.api.nvim_exec "        hi LspReferenceRead cterm=bold ctermbg=red guibg=yellow
        hi LspReferenceText cterm=bold ctermbg=red guibg=yellow
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=yellow
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer=abuf> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer=abuf> lua vim.lsp.buf.clear_references()
        augroup END
        " false))
  (when client.server_capabilities.colorProvider
    ((. (require :document-color) :buf_attach) bufnr)))

(fn on-attach.clojure [client bufnr]
  (on-attach.generic client bufnr)
  ((. (require :lsp-format) :on_attach) client))

(fn on-attach.python [client bufnr]
  (on-attach.generic client bufnr)
  ((. (require :lsp-format) :on_attach) client))

(fn on-attach.lua [client bufnr] (on-attach.generic client bufnr))

(fn on-attach.typescript [client bufnr]
  (on-attach.generic client bufnr)
  ((. (require :lsp-format) :on_attach) client))

(fn on-attach.null [client bufnr]
  (let [augroup (vim.api.nvim_create_augroup :LspFormatting {:clear true})]
    (when (client.supports_method :textDocument/formatting)
      (vim.api.nvim_create_autocmd :BufWritePre
                                   {:buffer bufnr
                                    :callback (fn []
                                                (vim.lsp.buf.format {: bufnr
                                                                     :filter (fn [client]
                                                                               (= client.name
                                                                                  :null-ls))
                                                                     :timeout_ms 2000}))
                                    :group augroup}))))

on-attach


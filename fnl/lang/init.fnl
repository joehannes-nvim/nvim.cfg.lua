(local lspconfig (require :lspconfig))
((. (require :mason) :setup))
((. (require :mason-lspconfig) :setup) {:automatic_installation true})

(local cfg (require :lang/setup))

(local my-servers {:clojure :clojure_lsp
                   :fennel :fennel_language_server
                   :css :cssls
                   :cssmodules :cssmodules_ls
                   :efm :efm
                   :graphql :graphql
                   :html :html
                   :json :jsonls
                   :lua :lua_ls
                   :python :pyright
                   :rust :rust_analyzer
                   :sourcekit :sourcekit
                   :tailwind :tailwindcss
                   :typescript :tsserver})

(vim.fn.sign_define :LspDiagnosticsSignError
                    {:numhl :LspDiagnosticsDefaultError :text "✘"})

(vim.fn.sign_define :LspDiagnosticsSignWarning
                    {:numhl :LspDiagnosticsDefaultWarning :text ""})

(vim.fn.sign_define :LspDiagnosticsSignInformation
                    {:numhl :LspDiagnosticsDefaultInformation :text ""})

(vim.fn.sign_define :LspDiagnosticsSignHint
                    {:numhl :LspDiagnosticsDefaultHint :text ""})

(vim.fn.sign_define :DiagnosticSignError
                    {:numhl :LspDiagnosticsDefaultError :text "✘"})

(vim.fn.sign_define :DiagnosticSignWarn
                    {:numhl :LspDiagnosticsDefaultWarning :text ""})

(vim.fn.sign_define :DiagnosticSignInfo
                    {:numhl :LspDiagnosticsDefaultInformation :text ""})

(vim.fn.sign_define :DiagnosticSignHint
                    {:numhl :LspDiagnosticsDefaultHint :text ""})

(each [server name (pairs my-servers)]
  (when (= server :fennel)
        (do
          ((. cfg server))
          ((. lspconfig name :setup) {})))
  (if (accumulate [truthy false
                   _ s (ipairs [:json :css :cssmodules :lua :python :clojure :efm])]
        (or truthy (= server s)))
      ((. lspconfig name :setup) ((. cfg server)))
      (= server :typescript)
      ((. (require :typescript) :setup) {:debug false
                                         :disable_commands false
                                         :server ((. cfg server))})
      ((. lspconfig name :setup) (cfg.generic))))

(vim.cmd "do User LspAttachBuffers")


(local root-pattern (. (require :lspconfig.util) :root_pattern))

(local on-attach (require :lang/attach))

(local capabilities (require :lang/capabilities))

(local lspconfig (require :lspconfig))

(local setup {})

(local sumneko-root-path
       (.. (vim.fn.stdpath :data)
           :/lsp_servers/sumneko_lua/extension/server/bin))

(local sumneko-binary (.. sumneko-root-path :/lua-language-server))

(fn setup.generic []
  (let [opts {: capabilities
              :on_attach on-attach.generic}]
    opts))

(fn setup.diagnostic []
  (let [opts {: capabilities
              :filetypes [:javascript
                          :javascriptreact
                          :typescript
                          :typescriptreact]
              :init_options {:filetypes {:javascript :eslint
                                         :javascriptreact :eslint
                                         :typescript :eslint
                                         :typescriptreact :eslint}
                             :linters {:eslint {:args [:--cache
                                                       :--stdin
                                                       :--stdin-filename
                                                       "%filepath"
                                                       :--format
                                                       :json]
                                                :command :eslint_d
                                                :debounce 100
                                                :parseJson {:column :column
                                                            :endColumn :endColumn
                                                            :endLine :endLine
                                                            :errorsRoot "[0].messages"
                                                            :line :line
                                                            :message "${message} [${ruleId}]"
                                                            :security :severity}
                                                :rootPatterns [:.eslintrc.js
                                                               :.eslintrc.json
                                                               :.eslintrc
                                                               :package.json]
                                                :securities {1 :warning
                                                             2 :error}
                                                :sourceName :eslint}}}
              :on_attach on-attach.minimal}]
    opts))

(fn setup.eslint []
  (let [opts {: capabilities
              :on_attach on-attach.minimal
              :settings {:format {:enable false}}}]
    opts))

(fn setup.json []
  (let [opts {: capabilities
              :on_attach on-attach.generic
              :settings {:json {:schemas [{:fileMatch [:package.json]
                                           :url "https://json.schemastore.org/package.json"}
                                          {:fileMatch [:tsconfig*.json]
                                           :url "https://json.schemastore.org/tsconfig.json"}
                                          {:fileMatch [:.prettierrc
                                                       :.prettierrc.json
                                                       :prettier.config.json]
                                           :url "https://json.schemastore.org/prettierrc.json"}
                                          {:fileMatch [:.eslintrc
                                                       :.eslintrc.json]
                                           :url "https://json.schemastore.org/eslintrc.json"}
                                          {:fileMatch [:.babelrc
                                                       :.babelrc.json
                                                       :babel.config.json]
                                           :url "https://json.schemastore.org/babelrc.json"}
                                          {:fileMatch [:lerna.json]
                                           :url "https://json.schemastore.org/lerna.json"}
                                          {:fileMatch [:now.json :vercel.json]
                                           :url "https://json.schemastore.org/now.json"}
                                          {:fileMatch [:ecosystem.json]
                                           :url "https://json.schemastore.org/pm2-ecosystem.json"}]}}}]
    opts))

(fn setup.typescript []
  (let [opts {: capabilities
              :handlers {:textDocument/hover (vim.lsp.with vim.lsp.handlers.hover
                                               {:border :rounded})
                         :textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help
                                                       {:border :rounded})}
              :on_attach on-attach.typescript
              :settings {:filetypes [:javascript
                                     :javascriptreact
                                     :typescript
                                     :typescriptreact]
                         :format {:enable true}}}]
    opts))

(fn setup.clojure []
  (let [opts {: capabilities
              :handlers {:textDocument/hover (vim.lsp.with vim.lsp.handlers.hover
                                               {:border :rounded})
                         :textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help
                                                       {:border :rounded})}
              :on_attach on-attach.clojure
              :settings {:filetypes [:clojure :clojurescript :clojuredart :cljd :cljs :edn]
                         :format {:enable true}}}]
    opts))

(fn setup.fennel []
  (tset (require :lspconfig.configs)
        :fennel_language_server
        {:default_config
          {:cmd ["/home/joehannes/.cargo/bin/fennel-language-server"]
           :filetypes [:fennel]
           :single_file_support true
           :root_dir (lspconfig.util.root_pattern "fnl")
           :settings {:fennel {:workspace {:library (vim.api.nvim_list_runtime_paths)}
                               :diagnostics {:globals ["set-forcibly!" "vim" (unpack (vim.tbl_keys _G))]}}}}}))

(fn setup.dart []
  (let [opts {: capabilities
              :handlers {:textDocument/hover (vim.lsp.with vim.lsp.handlers.hover
                                               {:border :rounded})
                         :textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help
                                                       {:border :rounded})}
              :on_attach on-attach.generic
              :settings {:format {:enable true}}
              :server {:dartls {:cmd [:dart :language-server "--protocol=lsp"]}}}]
    opts))

(fn setup.rust_analyzer []
  (let [opts {: capabilities
              :handlers {:textDocument/hover (vim.lsp.with vim.lsp.handlers.hover
                                               {:border :rounded})
                         :textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help
                                                       {:border :rounded})}
              :on_attach on-attach.generic
              :settings {:format {:enable true}}}]
    opts))

(fn setup.python []
  (let [opts {: capabilities
              :handlers {:textDocument/hover (vim.lsp.with vim.lsp.handlers.hover
                                               {:border :rounded})
                         :textDocument/signatureHelp (vim.lsp.with vim.lsp.handlers.signature_help
                                                       {:border :rounded})}
              :on_attach on-attach.python
              :settings {:format {:enable true}
                         :pyright {:analysis {:autoImportCompletions true
                                              :autoSearchPaths true
                                              :diagnosticMode :workspace
                                              :useLibraryCodeForTypes true}
                                   :disableOrganizeImports false}}}]
    opts))

(fn setup.lua []
  (let [opts {: capabilities
              :cmd [sumneko-binary :-E (.. sumneko-root-path :/main.lua)]
              :on_attach (fn [client bufnr]
                           (on-attach.lua client bufnr)
                           ((. (require :lsp-format) :on_attach) client))
              :settings {:Lua {:completion {:callSnippet :Replace}
                               :diagnostics {:globals [:vim]}
                               :runtime {:path (vim.split package.path ";")
                                         :version :LuaJIT}
                               :workspace {:checkThirdParty false :library {}}}
                         :format {:enable true}}}]
    opts))
(fn setup.css []
  (let [opts {: capabilities
              :on_attach on-attach.minimal
              :settings {:cmd [:vscode-css-language-server :--stdio]
                         :css {:lint {:unknownAtRules :ignore} :validate true}
                         :filetypes [:css :scss :less]
                         :less {:lint {:unknownAtRules :ignore} :validate true}
                         :scss {:lint {:unknownAtRules :ignore} :validate true}}}]
    opts))
(fn setup.cssmodules []
  (let [opts {: capabilities
              :on_attach on-attach.minimal
              :settings {:cmd [:cssmodules-language-server]
                         :filetypes [:javascript
                                     :javascriptreact
                                     :typescript
                                     :typescriptreact]}}]
    opts))
(fn setup.efm []
  (let [efmls (require :efmls-configs)
        efm-fs (require :efmls-configs.fs)
        root-path (vim.api.nvim_call_function :getcwd {})
        eslint-cfg-path (or (table.foreach [:.eslintrc.js
                                            :.eslintrc.cjs
                                            :.eslintrc.yaml
                                            :.eslintrc.yml
                                            :.eslintrc.json]
                                           (fn [_ value]
                                             (or (and (my.fs.exists (.. root-path
                                                                        "/"
                                                                        value))
                                                      (.. root-path "/" value))
                                                 nil)))
                            (.. root-path :/package.json))
        prettier-cfg-path (or (table.foreach [:.prettierrc
                                              :.prettierrc.json
                                              :.prettierrc.yml
                                              :.prettierrc.yaml
                                              :.prettierrc.json5
                                              :.prettierrc.js
                                              :.prettierrc.cjs
                                              :.prettierrc.config.js
                                              :.prettierrc.config.cjs
                                              :.prettierrc.toml]
                                             (fn [_ value]
                                               (or (and (my.fs.exists (.. root-path
                                                                          "/"
                                                                          value))
                                                        (.. root-path "/" value))
                                                   nil)))
                              (.. root-path :/package.json))
        stylelint (require :efmls-configs.linters.stylelint)
        eslint (require :efmls-configs.linters.eslint_d)
        prettier-default (require :efmls-configs.formatters.prettier)
        prettier {:formatCommand (string.format (.. "%s --stdin --stdin-filepath ${INPUT}"
                                                    " --eslint-config-path "
                                                    eslint-cfg-path " --config "
                                                    prettier-cfg-path)
                                                (efm-fs.executable :prettier-eslint
                                                                   efm-fs.Scope.NODE))
                  :formatStdin true}
        clj-kondo (require :plugins/config/clj_kondo)
        joker (require :efmls-configs.formatters.joker)
        handlers {:textDocument/publishDiagnostics (vim.lsp.with vim.lsp.diagnostic.on_publish_diagnostics
                                                     {:signs true
                                                      :underline true
                                                      :update_in_insert false
                                                      :virutal_text true})}
        init-opts {: handlers
                   :init_options {:documentFormatting true
                                  :documentRangeFormatting true}
                   :on_attach on-attach.minimal}
        languages {:css {:formatter prettier-default :linter stylelint}
                   :javascript {:formatter prettier :linter eslint}
                   :javascriptreact {:formatter prettier :linter eslint}
                   :scss {:formatter prettier-default :linter stylelint}
                   :typescript {:formatter prettier :linter eslint}
                   :typescriptreact {:formatter prettier :linter eslint}}]
    (vim.tbl_deep_extend :force init-opts
                    {:filetypes (vim.tbl_keys languages)
                     :settings {: languages :rootMarkers [:.git/]}})))
(fn setup.generic []
  (let [opts {:autostart true
              : capabilities
              :on_attach on-attach.minimal
              :settings {:format {:enable false}}}]
    opts))
(fn setup.null []
  (let [ls (require :null-ls)]
    (ls.setup {:on_attach on-attach.null_ls
               :sources [ls.builtins.diagnostics.eslint_d
                         ls.builtins.code_actions.eslint_d
                         ls.builtins.formatting.prettier]
               :update_in_insert true})))

setup

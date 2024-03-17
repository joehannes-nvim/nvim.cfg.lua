; ### AstroNvim LSP Utils
;
; LSP related utility functions to use within AstroNvim and user configurations.
;
; This module can be loaded with `local lsp_utils = require("astronvim.utils.lsp")`
;
; @module astronvim.utils.lsp
; @see astronvim.utils
; @copyright 2022
; @license GNU General Public License v3.0


(local M {})
(local tbl-contains vim.tbl_contains)
(local tbl-isempty vim.tbl_isempty)
(local user-opts _G.my.astro.user_opts)
(local utils (require :utils.astro))
(local conditional-func utils.conditional_func)
(local is-available utils.is_available)
(local extend-tbl utils.extend_tbl)
(local server-config :lsp.config.)
(local setup-handlers
       (user-opts :lsp.setup_handlers
                  [(fn [server opts]
                     ((. (. (require :lspconfig) server) :setup) opts))]))
(set M.diagnostics {0 {} 1 {} 2 {} 3 {}})
(set M.setup_diagnostics
     (fn [signs]
       (let [default-diagnostics (_G.my.astro.user_opts :diagnostics
                                                      {:float {:border :rounded
                                                               :focused false
                                                               :header ""
                                                               :prefix ""
                                                               :source :always
                                                               :style :minimal}
                                                       :severity_sort true
                                                       :signs {:active signs}
                                                       :underline true
                                                       :update_in_insert true
                                                       :virtual_text true})]
         (set M.diagnostics {0 (extend-tbl default-diagnostics
                                           {:signs false
                                            :underline false
                                            :update_in_insert false
                                            :virtual_text false})
                             1 (extend-tbl default-diagnostics
                                           {:signs false :virtual_text false})
                             2 (extend-tbl default-diagnostics
                                           {:virtual_text false})
                             3 default-diagnostics})
         (vim.diagnostic.config (. M.diagnostics vim.g.diagnostics_mode)))))
(set M.formatting
     (user-opts :lsp.formatting {:disabled {} :format_on_save {:enabled true}}))
(when (= (type M.formatting.format_on_save) :boolean)
  (set M.formatting.format_on_save {:enabled M.formatting.format_on_save}))
(set M.format_opts (vim.deepcopy M.formatting))
(set M.format_opts.disabled nil)
(set M.format_opts.format_on_save nil)
(set M.format_opts.filter
     (fn [client]
       (let [filter M.formatting.filter
             disabled (or M.formatting.disabled {})]
         (not (or (vim.tbl_contains disabled client.name)
                  (and (= (type filter) :function) (not (filter client))))))))
(set M.setup (fn [server]
               (let [(config-avail config) (pcall require
                                                  (.. :lspconfig.server_configurations.
                                                      server))]
                 (when (or (not config-avail) (not config.default_config))
                   (local server-definition
                          (user-opts (.. server-config server)))
                   (when server-definition.cmd
                     (tset (require :lspconfig.configs) server
                           {:default_config server-definition})))
                 (local opts (M.config server))
                 (local setup-handler
                        (or (. setup-handlers server) (. setup-handlers 1)))
                 (when (and (not (vim.tbl_contains _G.my.astro.lsp.skip_setup
                                                   server))
                            setup-handler)
                   (setup-handler server opts)))))
(fn M.has_capability [capability filter]
  (each [_ client (ipairs (vim.lsp.get_active_clients filter))]
    (when (client.supports_method capability) (lua "return true")))
  false)
(fn add-buffer-autocmd [augroup bufnr autocmds]
  (when (not (vim.tbl_islist autocmds)) (set-forcibly! autocmds [autocmds]))
  (local (cmds-found cmds)
         (pcall vim.api.nvim_get_autocmds {:buffer bufnr :group augroup}))
  (when (or (not cmds-found) (vim.tbl_isempty cmds))
    (vim.api.nvim_create_augroup augroup {:clear false})
    (each [_ autocmd (ipairs autocmds)] (local events autocmd.events)
      (set autocmd.events nil)
      (set autocmd.group augroup)
      (set autocmd.buffer bufnr)
      (vim.api.nvim_create_autocmd events autocmd))))
(fn del-buffer-autocmd [augroup bufnr]
  (let [(cmds-found cmds) (pcall vim.api.nvim_get_autocmds
                                 {:buffer bufnr :group augroup})]
    (when cmds-found
      (vim.tbl_map (fn [cmd] (vim.api.nvim_del_autocmd cmd.id)) cmds))))
(set M.on_attach
     (fn [client bufnr]
       (let [lsp-mappings ((. (require :utils.astro) :empty_map_table))]
         (tset lsp-mappings.n :<leader>ld
               {1 (fn [] (vim.diagnostic.open_float))
                :desc "Hover diagnostics"})
         (tset lsp-mappings.n "[d"
               {1 (fn [] (vim.diagnostic.goto_prev))
                :desc "Previous diagnostic"})
         (tset lsp-mappings.n "]d"
               {1 (fn [] (vim.diagnostic.goto_next)) :desc "Next diagnostic"})
         (tset lsp-mappings.n :gl
               {1 (fn [] (vim.diagnostic.open_float))
                :desc "Hover diagnostics"})
         (when (is-available :telescope.nvim)
           (tset lsp-mappings.n :<leader>lD
                 {1 (fn []
                      ((. (require :telescope.builtin) :diagnostics)))
                  :desc "Search diagnostics"}))
         (when (is-available :mason-lspconfig.nvim)
           (tset lsp-mappings.n :<leader>li
                 {1 :<cmd>LspInfo<cr> :desc "LSP information"}))
         (when (is-available :null-ls.nvim)
           (tset lsp-mappings.n :<leader>lI
                 {1 :<cmd>NullLsInfo<cr> :desc "Null-ls information"}))
         (when (client.supports_method :textDocument/codeAction)
           (tset lsp-mappings.n :<leader>la
                 {1 (fn [] (vim.lsp.buf.code_action)) :desc "LSP code action"})
           (tset lsp-mappings.v :<leader>la (. lsp-mappings.n :<leader>la)))
         (when (client.supports_method :textDocument/codeLens)
           (add-buffer-autocmd :lsp_codelens_refresh bufnr
                               {:callback (fn []
                                            (when (not (M.has_capability :textDocument/codeLens
                                                                         {: bufnr}))
                                              (del-buffer-autocmd :lsp_codelens_refresh
                                                                  bufnr)
                                              (lua "return "))
                                            (when vim.g.codelens_enabled
                                              (vim.lsp.codelens.refresh)))
                                :desc "Refresh codelens"
                                :events [:InsertLeave :BufEnter]})
           (when vim.g.codelens_enabled (vim.lsp.codelens.refresh))
           (tset lsp-mappings.n :<leader>ll
                 {1 (fn [] (vim.lsp.codelens.refresh))
                  :desc "LSP CodeLens refresh"})
           (tset lsp-mappings.n :<leader>lL
                 {1 (fn [] (vim.lsp.codelens.run)) :desc "LSP CodeLens run"}))
         (when (client.supports_method :textDocument/declaration)
           (tset lsp-mappings.n :gD
                 {1 (fn [] (vim.lsp.buf.declaration))
                  :desc "Declaration of current symbol"}))
         (when (client.supports_method :textDocument/definition)
           (tset lsp-mappings.n :gd
                 {1 (fn [] (vim.lsp.buf.definition))
                  :desc "Show the definition of current symbol"}))
         (when (and (client.supports_method :textDocument/formatting)
                    (not (tbl-contains M.formatting.disabled client.name)))
           (tset lsp-mappings.n :<leader>lf
                 {1 (fn [] (vim.lsp.buf.format M.format_opts))
                  :desc "Format buffer"})
           (tset lsp-mappings.v :<leader>lf (. lsp-mappings.n :<leader>lf))
           (vim.api.nvim_buf_create_user_command bufnr :Format
                                                 (fn []
                                                   (vim.lsp.buf.format M.format_opts))
                                                 {:desc "Format file with LSP"})
           (local autoformat M.formatting.format_on_save)
           (local filetype
                  (vim.api.nvim_get_option_value :filetype {:buf bufnr}))
           (when (and (and autoformat.enabled
                           (or (tbl-isempty (or autoformat.allow_filetypes {}))
                               (tbl-contains autoformat.allow_filetypes
                                             filetype)))
                      (or (tbl-isempty (or autoformat.ignore_filetypes {}))
                          (not (tbl-contains autoformat.ignore_filetypes
                                             filetype))))
             (add-buffer-autocmd :lsp_auto_format bufnr
                                 {:callback (fn []
                                              (when (not (M.has_capability :textDocument/formatting
                                                                           {: bufnr}))
                                                (del-buffer-autocmd :lsp_auto_format
                                                                    bufnr)
                                                (lua "return "))
                                              (var autoformat-enabled
                                                   vim.b.autoformat_enabled)
                                              (when (= autoformat-enabled nil)
                                                (set autoformat-enabled
                                                     vim.g.autoformat_enabled))
                                              (when (and autoformat-enabled
                                                         (or (not autoformat.filter)
                                                             (autoformat.filter bufnr)))
                                                (vim.lsp.buf.format (extend-tbl M.format_opts
                                                                                {: bufnr}))))
                                  :desc "autoformat on save"
                                  :events :BufWritePre})
             (tset lsp-mappings.n :<leader>uf
                   {1 (fn []
                        ((. (require :utils.astro.ui)
                            :toggle_buffer_autoformat)))
                    :desc "Toggle autoformatting (buffer)"})
             (tset lsp-mappings.n :<leader>uF
                   {1 (fn []
                        ((. (require :utils.astro.ui) :toggle_autoformat)))
                    :desc "Toggle autoformatting (global)"})))
         (when (client.supports_method :textDocument/documentHighlight)
           (add-buffer-autocmd :lsp_document_highlight bufnr
                               [{:callback (fn []
                                             (when (not (M.has_capability :textDocument/documentHighlight
                                                                          {: bufnr}))
                                               (del-buffer-autocmd :lsp_document_highlight
                                                                   bufnr)
                                               (lua "return "))
                                             (vim.lsp.buf.document_highlight))
                                 :desc "highlight references when cursor holds"
                                 :events [:CursorHold :CursorHoldI]}
                                {:callback (fn []
                                             (vim.lsp.buf.clear_references))
                                 :desc "clear references when cursor moves"
                                 :events [:CursorMoved :CursorMovedI :BufLeave]}]))
         (when (client.supports_method :textDocument/hover)
           (when (= (vim.fn.has :nvim-0.10) 0)
             (tset lsp-mappings.n :K
                   {1 (fn [] (vim.lsp.buf.hover)) :desc "Hover symbol details"})))
         (when (client.supports_method :textDocument/implementation)
           (tset lsp-mappings.n :gI
                 {1 (fn [] (vim.lsp.buf.implementation))
                  :desc "Implementation of current symbol"}))
         (when (client.supports_method :textDocument/inlayHint)
           (when (= vim.b.inlay_hints_enabled nil)
             (set vim.b.inlay_hints_enabled vim.g.inlay_hints_enabled))
           (when vim.lsp.inlay_hint
             (when vim.b.inlay_hints_enabled
               (vim.lsp.inlay_hint.enable bufnr true))
             (tset lsp-mappings.n :<leader>uH
                   {1 (fn []
                        ((. (require :utils.astro.ui)
                            :toggle_buffer_inlay_hints) bufnr))
                    :desc "Toggle LSP inlay hints (buffer)"})))
         (when (client.supports_method :textDocument/references)
           (tset lsp-mappings.n :gr
                 {1 (fn [] (vim.lsp.buf.references))
                  :desc "References of current symbol"})
           (tset lsp-mappings.n :<leader>lR
                 {1 (fn [] (vim.lsp.buf.references)) :desc "Search references"}))
         (when (client.supports_method :textDocument/rename)
           (tset lsp-mappings.n :<leader>lr
                 {1 (fn [] (vim.lsp.buf.rename)) :desc "Rename current symbol"}))
         (when (client.supports_method :textDocument/signatureHelp)
           (tset lsp-mappings.n :<leader>lh
                 {1 (fn [] (vim.lsp.buf.signature_help))
                  :desc "Signature help"}))
         (when (client.supports_method :textDocument/typeDefinition)
           (tset lsp-mappings.n :gy
                 {1 (fn [] (vim.lsp.buf.type_definition))
                  :desc "Definition of current type"}))
         (when (client.supports_method :workspace/symbol)
           (tset lsp-mappings.n :<leader>lG
                 {1 (fn [] (vim.lsp.buf.workspace_symbol))
                  :desc "Search workspace symbols"}))
         (when (and (client.supports_method :textDocument/semanticTokens/full)
                    vim.lsp.semantic_tokens)
           (if vim.g.semantic_tokens_enabled
               (do
                 (tset (. vim.b bufnr) :semantic_tokens_enabled true)
                 (tset lsp-mappings.n :<leader>uY
                       {1 (fn []
                            ((. (require :utils.astro.ui)
                                :toggle_buffer_semantic_tokens) bufnr))
                        :desc "Toggle LSP semantic highlight (buffer)"}))
               (set client.server_capabilities.semanticTokensProvider nil)))
         (when (is-available :telescope.nvim)
           (when lsp-mappings.n.gd
             (tset lsp-mappings.n.gd 1
                   (fn []
                     ((. (require :telescope.builtin) :lsp_definitions)))))
           (when lsp-mappings.n.gI
             (tset lsp-mappings.n.gI 1
                   (fn []
                     ((. (require :telescope.builtin) :lsp_implementations)))))
           (when lsp-mappings.n.gr
             (tset lsp-mappings.n.gr 1
                   (fn []
                     ((. (require :telescope.builtin) :lsp_references)))))
           (when (. lsp-mappings.n :<leader>lR)
             (tset (. lsp-mappings.n :<leader>lR) 1
                   (fn []
                     ((. (require :telescope.builtin) :lsp_references)))))
           (when lsp-mappings.n.gy
             (tset lsp-mappings.n.gy 1
                   (fn []
                     ((. (require :telescope.builtin) :lsp_type_definitions)))))
           (when (. lsp-mappings.n :<leader>lG)
             (tset (. lsp-mappings.n :<leader>lG) 1
                   (fn []
                     (vim.ui.input {:prompt "Symbol Query: (leave empty for word under cursor)"}
                                   (fn [query]
                                     (when query
                                       (when (= query "")
                                         (set-forcibly! query
                                                        (vim.fn.expand :<cword>)))
                                       ((. (require :telescope.builtin)
                                           :lsp_workspace_symbols) {:prompt_title (: "Find word (%s)" :format query)}))))))))
         (when (not (vim.tbl_isempty lsp-mappings.v))
           (tset lsp-mappings.v :<leader>l
                 {:desc (.. (utils.get_icon :ActiveLSP 1 true) :LSP)}))
         (utils.set_mappings (user-opts :lsp.mappings lsp-mappings)
                             {:buffer bufnr})
         (each [id _ (pairs _G.my.astro.lsp.progress)]
           (when (not (next (vim.lsp.get_active_clients {:id (tonumber (id:match "^%d+"))})))
             (tset _G.my.astro.lsp.progress id nil)))
         (local on-attach-override (user-opts :lsp.on_attach nil false))
         (conditional-func on-attach-override true client bufnr))))
(set M.capabilities (vim.lsp.protocol.make_client_capabilities))
(set M.capabilities.textDocument.completion.completionItem.documentationFormat
     [:markdown :plaintext])
(set M.capabilities.textDocument.completion.completionItem.snippetSupport true)
(set M.capabilities.textDocument.completion.completionItem.preselectSupport
     true)
(set M.capabilities.textDocument.completion.completionItem.insertReplaceSupport
     true)
(set M.capabilities.textDocument.completion.completionItem.labelDetailsSupport
     true)
(set M.capabilities.textDocument.completion.completionItem.deprecatedSupport
     true)
(set M.capabilities.textDocument.completion.completionItem.commitCharactersSupport
     true)
(set M.capabilities.textDocument.completion.completionItem.tagSupport
     {:valueSet [1]})
(set M.capabilities.textDocument.completion.completionItem.resolveSupport
     {:properties [:documentation :detail :additionalTextEdits]})
(set M.capabilities.textDocument.foldingRange
     {:dynamicRegistration false :lineFoldingOnly true})
(set M.capabilities (user-opts :lsp.capabilities M.capabilities))
(set M.flags (user-opts :lsp.flags))
(fn M.config [server-name]
  (let [server (. (require :lspconfig) server-name)
        lsp-opts (extend-tbl server
                             {:capabilities M.capabilities :flags M.flags})]
    (when (= server-name :jsonls)
      (local (schemastore-avail schemastore) (pcall require :schemastore))
      (when schemastore-avail
        (set lsp-opts.settings
             {:json {:schemas (schemastore.json.schemas)
                     :validate {:enable true}}})))
    (when (= server-name :yamlls)
      (local (schemastore-avail schemastore) (pcall require :schemastore))
      (when schemastore-avail
        (set lsp-opts.settings {:yaml {:schemas (schemastore.yaml.schemas)}})))
    (when (= server-name :lua_ls)
      (pcall require :neodev)
      (set lsp-opts.before_init
           (fn [param config]
             (when vim.b.neodev_enabled
               (each [_ astronvim-config (ipairs _G.my.astro.supported_configs)]
                 (when (param.rootPath:match astronvim-config)
                   (table.insert config.settings.Lua.workspace.library
                                 (.. _G.my.astro.install.home :/lua))
                   (lua :break))))))
      (set lsp-opts.settings {:Lua {:workspace {:checkThirdParty false}}}))
    (local opts (user-opts (.. server-config server-name) lsp-opts))
    (local old-on-attach server.on_attach)
    (local user-on-attach opts.on_attach)
    (set opts.on_attach
         (fn [client bufnr] (conditional-func old-on-attach true client bufnr)
           (M.on_attach client bufnr)
           (conditional-func user-on-attach true client bufnr)))
    opts))
M

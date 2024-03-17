(tset vim.lsp.handlers :textDocument/codeAction
      (. (require :lsputil.codeAction) :code_action_handler))

(tset vim.lsp.handlers :textDocument/references
      (. (require :lsputil.locations) :references_handler))

(tset vim.lsp.handlers :textDocument/definition
      (. (require :lsputil.locations) :definition_handler))

(tset vim.lsp.handlers :textDocument/declaration
      (. (require :lsputil.locations) :declaration_handler))

(tset vim.lsp.handlers :textDocument/typeDefinition
      (. (require :lsputil.locations) :typeDefinition_handler))

(tset vim.lsp.handlers :textDocument/implementation
      (. (require :lsputil.locations) :implementation_handler))

(tset vim.lsp.handlers :textDocument/documentSymbol
      (. (require :lsputil.symbols) :document_handler))

(tset vim.lsp.handlers :workspace/symbol
      (. (require :lsputil.symbols) :workspace_handler))


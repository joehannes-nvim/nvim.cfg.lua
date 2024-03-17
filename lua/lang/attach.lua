-- [nfnl] Compiled from fnl/lang/attach.fnl by https://github.com/Olical/nfnl, do not edit.
local on_attach = {}
on_attach.minimal = function(client, bufnr)
  return vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end
on_attach.generic = function(client, bufnr)
  on_attach.minimal(client, bufnr)
  do end (require("nvim-navic")).attach(client, bufnr)
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec("        hi LspReferenceRead cterm=bold ctermbg=red guibg=yellow\n        hi LspReferenceText cterm=bold ctermbg=red guibg=yellow\n        hi LspReferenceWrite cterm=bold ctermbg=red guibg=yellow\n        augroup lsp_document_highlight\n        autocmd! * <buffer>\n        autocmd CursorHold <buffer=abuf> lua vim.lsp.buf.document_highlight()\n        autocmd CursorMoved <buffer=abuf> lua vim.lsp.buf.clear_references()\n        augroup END\n        ", false)
  else
  end
  if client.server_capabilities.colorProvider then
    return (require("document-color")).buf_attach(bufnr)
  else
    return nil
  end
end
on_attach.clojure = function(client, bufnr)
  on_attach.generic(client, bufnr)
  return (require("lsp-format")).on_attach(client)
end
on_attach.python = function(client, bufnr)
  on_attach.generic(client, bufnr)
  return (require("lsp-format")).on_attach(client)
end
on_attach.lua = function(client, bufnr)
  return on_attach.generic(client, bufnr)
end
on_attach.typescript = function(client, bufnr)
  on_attach.generic(client, bufnr)
  return (require("lsp-format")).on_attach(client)
end
on_attach.null = function(client, bufnr)
  local augroup = vim.api.nvim_create_augroup("LspFormatting", {clear = true})
  if client.supports_method("textDocument/formatting") then
    local function _3_()
      local function _4_(client0)
        return (client0.name == "null-ls")
      end
      return vim.lsp.buf.format({bufnr = bufnr, filter = _4_, timeout_ms = 2000})
    end
    return vim.api.nvim_create_autocmd("BufWritePre", {buffer = bufnr, callback = _3_, group = augroup})
  else
    return nil
  end
end
return on_attach

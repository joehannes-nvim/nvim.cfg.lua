-- [nfnl] Compiled from fnl/plugins/config/completion.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local cmp = require("cmp")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end
  local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return ((col ~= 0) and (((vim.api.nvim_buf_get_lines(0, (line - 1), line, true))[1]):sub(col, col):match("%s") == nil))
  end
  local function feedkey(key, mode)
    return vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end
  do end (cmp.event):on("confirm_done", cmp_autopairs.on_confirm_done())
  local source_mapping = {buffer = "[Buffer]", cmp_tabnine = "[TN]", nvim_lsp = "[LSP]", nvim_lua = "[Lua]", path = "[Path]"}
  local function _1_(entry, vim_item)
    vim_item.kind = (require("lspkind")).symbolic(vim_item.kind, {mode = "symbol"})
    vim_item.menu = source_mapping[entry.source.name]
    if (entry.source.name == "cmp_tabnine") then
      local detail = ((entry.completion_item.labelDetails or {})).detail
      vim_item.kind = "\239\131\167"
      if (detail and detail:find(".*%%.*")) then
        vim_item.kind = (vim_item.kind .. " " .. detail)
      else
      end
      if ((entry.completion_item.data or {})).multiline then
        vim_item.kind = (vim_item.kind .. " " .. "[ML]")
      else
      end
    else
    end
    local maxwidth = 80
    vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
    return vim_item
  end
  local function _5_()
    if cmp.visible() then
      return cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
    else
      return vim.api.nvim_feedkeys(t("<Down>"), "n", true)
    end
  end
  local function _7_(fallback)
    if cmp.visible() then
      return cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
    else
      return fallback()
    end
  end
  local function _9_()
    if cmp.visible() then
      return cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
    else
      return vim.api.nvim_feedkeys(t("<Up>"), "n", true)
    end
  end
  local function _11_(fallback)
    if cmp.visible() then
      return cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
    else
      return fallback()
    end
  end
  local function _13_(fallback)
    if cmp.visible() then
      return cmp.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})
    else
      return fallback()
    end
  end
  local function _15_()
    if cmp.visible() then
      return cmp.select_prev_item()
    else
      return nil
    end
  end
  local function _17_(fallback)
    if cmp.visible() then
      return cmp.select_next_item()
    elseif has_words_before() then
      return cmp.complete()
    else
      return fallback()
    end
  end
  local function _19_(args)
    return (require("luasnip")).lsp_expand(args.body)
  end
  cmp.setup({completion = {completeopt = "menu,menuone,noselect"}, experimental = {ghost_text = true}, formatting = {format = _1_}, mapping = {["<C-Esc>"] = cmp.mapping({c = cmp.mapping.close(), i = cmp.mapping.close()}), ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}), ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(( - 3)), {"i", "c"}), ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(3), {"i", "c"}), ["<C-n>"] = cmp.mapping({c = _5_, i = _7_}), ["<C-p>"] = cmp.mapping({c = _9_, i = _11_}), ["<CR>"] = cmp.mapping({c = _13_, i = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false})}), ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({behavior = cmp.SelectBehavior.Select}), {"i"}), ["<S-Tab>"] = cmp.mapping(_15_, {"i", "s"}), ["<Tab>"] = cmp.mapping(_17_, {"i", "s"}), ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({behavior = cmp.SelectBehavior.Select}), {"i"})}, snippet = {expand = _19_}, sources = {{name = "cmp_tabnine"}, {name = "luasnip"}, {name = "nvim_lsp"}, {name = "treesitter"}, {name = "nvim_lsp_signature_help"}, {name = "path"}, {keyworld_length = 3, name = "npm"}, {name = "nvim_lua"}, {name = "calc"}, {name = "spell"}, {name = "emoji"}}, view = {entries = {name = "custom", selection_order = "near_cursor"}}})
  cmp.setup.cmdline(":", {completion = {autocomplete = {}}, sources = cmp.config.sources({{name = "path"}, {name = "cmdline"}})})
  return cmp.setup.cmdline("/", {completion = {autocomplete = {}}, sources = cmp.config.sources({{name = "nvim_lsp_document_symbol"}, {name = "buffer", option = {keyword_pattern = "[^[:blank:]].*"}}})})
end
return M

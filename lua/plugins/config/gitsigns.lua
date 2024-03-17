-- [nfnl] Compiled from fnl/plugins/config/gitsigns.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local function _1_(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = (opts or {})
      opts.buffer = bufnr
      return vim.keymap.set(mode, l, r, opts)
    end
    return map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
  return (require("gitsigns")).setup({attach_to_untracked = true, current_line_blame = true, current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>", current_line_blame_opts = {delay = 300, virt_text = true, virt_text_pos = "eol", ignore_whitespace = false}, max_file_length = 40000, numhl = true, on_attach = _1_, preview_config = {border = "single", col = 1, relative = "cursor", row = 0, style = "minimal"}, sign_priority = 6, signcolumn = true, signs = {add = {hl = "GitSignsAdd", linehl = "GitSignsAddLn", numhl = "GitSignsAddNr", text = "+"}, change = {hl = "GitSignsChange", linehl = "GitSignsChangeLn", numhl = "GitSignsChangeNr", text = "\226\148\130"}, changedelete = {hl = "GitSignsChange", linehl = "GitSignsChangeLn", numhl = "GitSignsChangeNr", text = "~"}, delete = {hl = "GitSignsDelete", linehl = "GitSignsDeleteLn", numhl = "GitSignsDeleteNr", text = "_"}, topdelete = {hl = "GitSignsDelete", linehl = "GitSignsDeleteLn", numhl = "GitSignsDeleteNr", text = "\226\128\190"}}, status_formatter = nil, update_debounce = 100, watch_gitdir = {follow_files = true, interval = 1000}, yadm = {enable = false}, linehl = false, word_diff = false})
end
return M

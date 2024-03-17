-- [nfnl] Compiled from fnl/plugins/preview.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  local glance = require("glance")
  local actions = glance.actions
  return glance.setup({border = {bottom_char = "=", enable = true, top_char = "="}, folds = {fold_closed = "\239\153\129", fold_open = "\239\152\191", folded = true}, height = 18, hooks = {}, indent_lines = {enable = true, icon = "\226\148\130"}, list = {position = "right", width = 0.33}, mappings = {list = {["<C-d>"] = actions.preview_scroll_win(( - 5)), ["<C-u>"] = actions.preview_scroll_win(5), ["<CR>"] = actions.enter_win("preview"), ["<Down>"] = actions.next, ["<Esc>"] = actions.close, ["<S-Tab>"] = actions.previous_location, ["<Tab>"] = actions.next_location, ["<Up>"] = actions.previous, ["<leader>l"] = actions.enter_win("preview"), Q = actions.close, j = actions.next, k = actions.previous, o = actions.jump, q = actions.close, s = actions.jump_split, t = actions.jump_tab, v = actions.jump_vsplit}, preview = {["<S-Tab>"] = actions.previous_location, ["<Tab>"] = actions.next_location, ["<leader>l"] = actions.enter_win("list"), Q = actions.close}}, preview_win_opts = {cursorline = true, number = true, wrap = true}, theme = {enable = true, mode = "auto"}, winbar = {enable = false}, zindex = 45})
end
local function _2_()
  local function _3_()
    require("hover.providers.lsp")
    require("hover.providers.gh")
    require("hover.providers.gh_user")
    require("hover.providers.man")
    return require("hover.providers.dictionary")
  end
  return (require("hover")).setup({init = _3_, preview_opts = {border = "rounded", winbar = nil}, title = true, winbar = nil})
end
local function _4_()
  return vim.cmd("        let g:dasht_results_window = 'tabnew'\n      ")
end
return {{"dnlhc/glance.nvim", config = _1_}, {"lewis6991/hover.nvim", config = _2_}, {"sunaku/vim-dasht", config = _4_}}

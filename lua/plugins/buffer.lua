-- [nfnl] Compiled from fnl/plugins/buffer.fnl by https://github.com/Olical/nfnl, do not edit.
local my = _G.my
local function _1_()
  return (require("scope")).setup()
end
local function _2_()
  local opts = {noremap = true, silent = true}
  return (require("bufresize")).setup({register = {keys = {{"n", "<leader>w<", "30<C-w><", opts}, {"n", "<leader>w>", "30<C-w>>", opts}, {"n", "<leader>w+", "10<C-w>+", opts}, {"n", "<leader>w-", "10<C-w>-", opts}, {"n", "<leader>w_", "<C-w>_", opts}, {"n", "<leader>w=", "<C-w>=", opts}, {"n", "<leader>w|", "<C-w>|", opts}, {"n", "<leader>wo", "<C-w>|<C-w>_", opts}}, trigger_events = {"BufWinEnter", "WinEnter"}}, resize = {keys = {}, trigger_events = {"VimResized"}}})
end
local function _3_()
  vim.o.winwidth = 12
  vim.o.winminwidth = 12
  vim.o.winheight = 20
  vim.o.winminheight = 1
  vim.o.equalalways = false
  return (require("windows")).setup({ignore = {buftype = {"quickfix"}, filetype = {"NvimTree", "neo-tree", "undotree", "gundo", "Outline", "flutterToolsOutline", "Trouble", "DiffviewFiles"}}})
end
local function _4_()
  vim.api.nvim_set_var("beacon_enable", true)
  vim.api.nvim_set_var("beacon_size", 80)
  vim.api.nvim_set_var("beacon_minimal_jump", 2)
  vim.api.nvim_set_var("beacon_ignore_filetypes", {"trouble", "telescope", "terminal", "fzf"})
  return vim.api.nvim_set_hl(0, "Beacon", {bg = my.color.my.magenta, ctermbg = "magenta"})
end
local function _5_()
  return (require("plugins.config.symbols_outline")).setup()
end
local function _6_()
  return (require("plugins.config.trouble")).setup()
end
local function _7_()
  return (require("plugins.config.zen")).setup()
end
local function _8_()
  return (require("twilight")).setup({context = 21, dimming = {alpha = 0.73, inactive = true}, exclude = {}, expand = {"function", "method", "table", "if_statement"}, treesitter = true})
end
local function _9_()
  return (require("plugins.config.scrollbar")).setup()
end
local function _10_()
  return (require("plugins.config.hlslens")).setup()
end
return {{"tiagovla/scope.nvim", config = _1_}, {"kwkarlwang/bufresize.nvim", config = _2_}, {"anuvyklack/windows.nvim", config = _3_, dependencies = {"anuvyklack/middleclass", "anuvyklack/animation.nvim"}}, {"danilamihailov/beacon.nvim", config = _4_}, {"simrat39/symbols-outline.nvim", config = _5_}, {"folke/trouble.nvim", config = _6_, dependencies = "kyazdani42/nvim-web-devicons"}, {"folke/zen-mode.nvim", config = _7_}, {"folke/twilight.nvim", config = _8_}, {"petertriho/nvim-scrollbar", config = _9_}, {"kevinhwang91/nvim-hlslens", config = _10_, dependencies = {"petertriho/nvim-scrollbar"}}}

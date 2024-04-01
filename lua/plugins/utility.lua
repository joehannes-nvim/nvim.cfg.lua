-- [nfnl] Compiled from fnl/plugins/utility.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return vim.fn["fzf#install"]()
end
local function _2_()
  return (require("hoversplit")).setup({})
end
local function _3_()
  local config = require("plugins/config/telescope")
  local neoclip = require("plugins/config/neoclip")
  config.setup()
  return neoclip.setup()
end
local function _4_()
  return (require("telescope-ag")).setup({})
end
local function _5_()
  return (require("plugins.config.scrollbar")).setup()
end
local function _6_()
  return (require("plugins.config.bqf")).setup()
end
local function _7_()
  return (require("tabout")).setup({backwards_tabkey = "<<", enable_backwards = true, exclude = {}, ignore_beginning = true, tabkey = ">>", tabouts = {{close = "'", open = "'"}, {close = "\"", open = "\""}, {close = "`", open = "`"}, {close = ")", open = "("}, {close = "]", open = "["}, {close = "}", open = "{"}, {close = ">", open = "<"}}, act_as_tab = false, completion = false, act_as_shift_tab = false})
end
local function _8_()
  return (require("jeskape")).setup({mappings = {["<Esc>"] = "<cmd>stopinsert<cr>", ["<leader>"] = {["<leader>"] = "<cmd>w<cr>"}, j = {k = "<cmd>stopinsert<cr><cmd>w!<cr>"}}, timeout = vim.o.timeoutlen})
end
local function _9_()
  return (require("plugins.config.pasteimg")).setup()
end
local function _10_()
  return (require("which-key")).setup({icons = {group = ""}, layout = {height = {min = 1, max = 25}, width = {min = 1, max = 25}, align = "center"}, hidden = {"<silent>", "<cmd>", "<Cmd>", "^:", "^ ", "^call ", "^lua "}})
end
return {{"editorconfig/editorconfig-vim"}, {"wakatime/vim-wakatime"}, {"chrisbra/unicode.vim"}, {"kkharji/sqlite.lua"}, {"junegunn/fzf", build = _1_}, {"roobert/hoversplit.nvim", config = _2_}, {"nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"}, {"nvim-telescope/telescope.nvim", config = _3_, dependencies = {"nvim-lua/popup.nvim", "nvim-lua/plenary.nvim", "kkharji/sqlite.lua", "nvim-telescope/telescope-project.nvim", "nvim-telescope/telescope-smart-history.nvim", "nvim-telescope/telescope-frecency.nvim", "nvim-telescope/telescope-symbols.nvim", "nvim-telescope/telescope-node-modules.nvim", "nvim-telescope/telescope-github.nvim", "nvim-telescope/telescope-arecibo.nvim", "nvim-telescope/telescope-ui-select.nvim", "joehannes-os/telescope-media-files.nvim", "debugloop/telescope-undo.nvim", "sudormrfbin/cheatsheet.nvim", "AckslD/nvim-neoclip.lua", "Azeirah/nvim-redux", "tiagovla/scope.nvim"}}, {"kelly-lin/telescope-ag", config = _4_, dependencies = "nvim-telescope/telescope.nvim"}, {"petertriho/nvim-scrollbar", config = _5_}, {"kevinhwang91/nvim-bqf", config = _6_, dependencies = {"fzf", "nvim-treesitter", "vim-grepper"}}, {"RRethy/vim-illuminate"}, {"abecodes/tabout.nvim", config = _7_, dependencies = {"nvim-cmp", "nvim-treesitter"}}, {"smitajit/bufutils.vim"}, {"arithran/vim-delete-hidden-buffers"}, {"Krafi2/jeskape.nvim", config = _8_}, {"HakonHarnes/img-clip.nvim", cmd = "PasteImage", config = _9_, keys = {{"<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image"}}, opts = {}}, {"folke/which-key.nvim", config = _10_}}

-- [nfnl] Compiled from fnl/plugins/coding.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("treesitter-context")).setup()
end
local function _2_()
  return (require("iswap")).setup()
end
local function _3_()
  return (require("todo-comments")).setup()
end
local function _4_()
  vim.g.skip_ts_context_commentstring_module = true
  return (require("ts_context_commentstring")).setup({})
end
local function _5_()
  return (require("plugins.config.autopairs")).setup()
end
local function _6_()
  return (require("Comment")).setup()
end
local function _7_()
  return (require("neodev")).setup({library = {plugins = {"neotest"}, types = true}})
end
local function _8_()
  local function _9_()
    return vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", ":close<CR>", {})
  end
  return (require("nvim-devdocs")).setup({float_win = {relative = "editor", height = 30, width = 140, border = "rounded"}, after_open = _9_})
end
return {{"huynle/ogpt.nvim", event = "VeryLazy", opts = {default_provider = "gemini", edgy = true, yank_register = "+", providers = {gemini = {enabled = true, api_host = os.getenv("GEMINI_API_HOST"), api_key = os.getenv("GEMINI_API_KEY"), model = "gemini-pro", api_params = {temperature = 0.5, topP = 0.99}, api_chat_params = {temperature = 0.5, topP = 0.99}}}, edit = {edgy = true}, popup = {edgy = true}, chat = {edgy = true}, single_window = false}, dependencies = {"MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"}}, {"subnut/nvim-ghost.nvim"}, {"nvim-treesitter/nvim-treesitter", branch = "master", build = ":TSUpdate", config = (require("plugins.config.treesitter")).ts_setup}, {"nvim-treesitter/nvim-treesitter-refactor", config = (require("plugins.config.treesitter")).ts_refactor_setup}, {"nvim-treesitter/nvim-treesitter-textobjects"}, {"chrisgrieser/nvim-various-textobjs", config = (require("plugins.config.treesitter")).ts_vto_setup}, {"RRethy/nvim-treesitter-textsubjects"}, {"nvim-treesitter/nvim-treesitter-context", config = _1_}, {"mfussenegger/nvim-ts-hint-textobject"}, {"wellle/targets.vim"}, {"mizlan/iswap.nvim", config = _2_}, {"folke/todo-comments.nvim", config = _3_, dependencies = "nvim-lua/plenary.nvim"}, {"JoosepAlviste/nvim-ts-context-commentstring", config = _4_}, {"haringsrob/nvim_context_vt"}, {"machakann/vim-sandwich"}, {"windwp/nvim-ts-autotag"}, {"p00f/nvim-ts-rainbow"}, {"windwp/nvim-autopairs", config = _5_, dependencies = {"windwp/nvim-ts-autotag"}}, {"numToStr/Comment.nvim", config = _6_}, {"antoinemadec/FixCursorHold.nvim"}, {"nvim-neotest/neotest", dependencies = {"nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "antoinemadec/FixCursorHold.nvim"}}, {"folke/neodev.nvim", config = _7_}, {"akinsho/flutter-tools.nvim", opts = {root_patterns = {"pubspec.yaml"}}, config = true, dependencies = {"nvim-lua/plenary.nvim", "stevearc/dressing.nvim"}, lazy = false}, {"luckasRanarison/nvim-devdocs", dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-treesitter/nvim-treesitter"}, opts = {}, config = _8_}, {"sheerun/vim-polyglot"}, {"othree/es.next.syntax.vim"}, {"othree/javascript-libraries-syntax.vim"}}

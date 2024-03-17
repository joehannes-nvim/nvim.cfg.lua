-- [nfnl] Compiled from fnl/plugins/completion.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("tabnine")).setup({disable_auto_comment = true, accept_keymap = "<C-Tab>", dismiss_keymap = "<C-BS>", debounce_ms = 500, suggestion_color = {gui = "#abba37"}, exclude_filetypes = {"TelescopePrompt", "NvimTree"}, log_file_path = nil})
end
local function _2_()
  do end (require("plugins.config.completion")).setup()
  return (require("cmp-npm")).setup({})
end
local function _3_()
  local tabnine = require("cmp_tabnine.config")
  return tabnine:setup({ignored_file_types = {}, max_lines = 50, max_num_results = 3, run_on_every_keystroke = true, snippet_placeholder = "..", sort = true, show_prediction_strength = false})
end
return {{"codota/tabnine-nvim", build = "./dl_binaries.sh", config = _1_}, {"hrsh7th/nvim-cmp", config = _2_, dependencies = {"nvim-lua/plenary.nvim", "hrsh7th/cmp-nvim-lsp", "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lua", "octaltree/cmp-look", "hrsh7th/cmp-path", "hrsh7th/cmp-calc", "f3fora/cmp-spell", "hrsh7th/cmp-emoji", "ray-x/cmp-treesitter", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-nvim-lsp-document-symbol", "hrsh7th/cmp-nvim-lsp-signature-help", "David-Kunz/cmp-npm", "windwp/nvim-autopairs"}}, {"saadparwaiz1/cmp_luasnip"}, {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-nvim-lua"}, {"octaltree/cmp-look"}, {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-calc"}, {"f3fora/cmp-spell"}, {"hrsh7th/cmp-emoji"}, {"ray-x/cmp-treesitter"}, {"hrsh7th/cmp-cmdline"}, {"hrsh7th/cmp-nvim-lsp-document-symbol"}, {"hrsh7th/cmp-nvim-lsp-signature-help"}, {"David-Kunz/cmp-npm"}, {"tzachar/cmp-tabnine", build = "./install.sh", config = _3_, dependencies = {"hrsh7th/nvim-cmp"}}, {"windwp/nvim-autopairs"}}

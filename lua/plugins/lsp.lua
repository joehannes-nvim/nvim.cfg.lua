-- [nfnl] Compiled from fnl/plugins/lsp.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("plugins.config.lspkind")).setup()
end
local function _2_()
  return (require("lsp-format")).setup({sync = true})
end
local function _3_()
  return (require("inc_rename")).setup()
end
local function _4_()
  return (require("plugins.config.lspcolors")).setup()
end
local function _5_()
  return (require("eagle")).setup({})
end
local function _6_()
  return (require("lsp-lens")).setup({})
end
return {{"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"}, {"neovim/nvim-lspconfig"}, {"jose-elias-alvarez/typescript.nvim"}, {"onsails/lspkind-nvim", config = _1_}, {"creativenull/efmls-configs-nvim", dependencies = {"neovim/nvim-lspconfig"}}, {"lukas-reineke/lsp-format.nvim", config = _2_}, {"weilbith/nvim-code-action-menu", cmd = "CodeActionMenu"}, {"smjonas/inc-rename.nvim", config = _3_}, {"folke/lsp-colors.nvim", config = _4_}, {"soulis-1256/eagle.nvim", config = _5_, lazy = false}, {"VidocqH/lsp-lens.nvim", config = _6_}}

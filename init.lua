--@diagnostic disable:undefined-global
vim.cmd([[
  set shell=/usr/bin/zsh
]])

vim.api.nvim_set_var("mapleader", " ")
vim.api.nvim_set_var("maplocalleader", ";")

require("utils")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
  vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" }) -- last stable release
end

-- As per lazy's install instructions, but insert hotpots path at the front
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  root = vim.fn.stdpath("data") .. "/lazy",
  spec = {
    import = "plugins",
  },
  defaults = { lazy = false, version = "*" },
  checker = { enabled = false },
  diff = {
    cmd = "git",
  },
  performance = {
    cache = {
      enabled = true,
    },
    rtp = {
      disabled_plugins = {
      },
    },
  },
  git = {
    timeout = 500,
  },
  ui = {
    custom_keys = {
    },
  },
  debug = false,
})

require("settings")
require("lang")
require("keymappings")
require("colorschemes")

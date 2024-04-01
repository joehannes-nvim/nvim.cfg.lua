-- [nfnl] Compiled from fnl/plugins/config/zen.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  local function _1_()
    local function _2_()
      vim.go.cmdheight = 1
      return nil
    end
    return vim.defer_fn(_2_, 0)
  end
  local function _3_(win)
    local function _4_()
      vim.cmd("e")
      vim.wo.foldmethod = "expr"
      vim.go.cmdheight = 0
      return nil
    end
    return vim.defer_fn(_4_, 100)
  end
  return (require("zen-mode")).setup({on_close = _1_, on_open = _3_, plugins = {gitsigns = {enabled = false}, kitty = {enabled = true, font = "+2"}, options = {enabled = false, showcmd = false, ruler = false}, tmux = {enabled = true}, twilight = {enabled = true}}, window = {backdrop = 0.5, height = 0.98, options = {cursorcolumn = true, cursorline = true, foldcolumn = "1", list = true, number = true, relativenumber = true, signcolumn = "auto:3"}, width = 130}})
end
return M

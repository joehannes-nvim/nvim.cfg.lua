-- [nfnl] Compiled from fnl/plugins/notes.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  do end (require("telekasten")).setup({home = vim.fn.expand("~/zettelkasten")})
  return vim.cmd("        hi tkLink ctermfg=Blue cterm=bold,underline guifg=Blue gui=bold,underline\n        hi tkBrackets ctermfg=Magenta guifg=Magenta\n      ")
end
return {{"renerocksai/calendar-vim"}, {"renerocksai/telekasten.nvim", config = _1_, dependencies = {"nvim-telescope/telescope.nvim"}}}

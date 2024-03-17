-- [nfnl] Compiled from fnl/plugins/config/bqf.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
vim.cmd("    hi BqfPreviewBorder guifg=#50a14f ctermfg=71\n    hi link BqfPreviewRange Search\n")
config.setup = function()
  local function _1_(bufnr)
    local ret = true
    local filename = vim.api.nvim_buf_get_name(bufnr)
    local fsize = vim.fn.getfsize(filename)
    if (fsize > (100 * 1024)) then
      ret = false
    elseif filename:match("^fugitive://") then
      ret = false
    else
    end
    return ret
  end
  return (require("bqf")).setup({auto_enable = true, filter = {fzf = {action_for = {["ctrl-c"] = "closeall", ["ctrl-q"] = "signtoggle", ["ctrl-t"] = "tabdrop", ["ctrl-v"] = "vsplit", ["ctrl-x"] = "split"}, extra_opts = {"--bind", "ctrl-o:toggle-all", "--prompt", "> ", "--delimiter", "|"}}}, func_map = {drop = "O", filter = "zn", filterr = "zN", fzffilter = "f", lastleave = "gi", nextfile = "j", nexthist = ">", open = "<CR>", openc = "o", prevfile = "k", prevhist = "<", pscrolldown = "<C-d>", pscrollorig = "gg", pscrollup = "<C-u>", ptoggleauto = "P", ptoggleitem = "p", ptogglemode = "<space><CR>", sclear = "z<TAB>", split = "<C-x>", stogglebuf = "'<TAB>", stoggledown = "<TAB>", stoggleup = "<S-TAB>", stogglevm = "<TAB>", tab = "t<CR>", tabb = "<C-t>", tabc = "to", tabdrop = "tO", vsplit = "<C-v>"}, magic_window = true, preview = {auto_preview = true, border_chars = {"\226\148\131", "\226\148\131", "\226\148\129", "\226\148\129", "\226\148\143", "\226\148\147", "\226\148\151", "\226\148\155", "\226\150\136"}, delay_syntax = 80, should_preview_cb = _1_, win_height = 30, win_vheight = 21, wrap = true}, auto_resize_height = false})
end
return config

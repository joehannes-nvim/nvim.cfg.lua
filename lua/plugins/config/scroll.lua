-- [nfnl] Compiled from fnl/plugins/config/scroll.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  local function _1_(info)
    if (info == "cursorline") then
      vim.wo.cursorline = true
      vim.wo.cursorcolumn = true
      return nil
    else
      return nil
    end
  end
  local function _3_(info)
    if (info == "cursorline") then
      vim.wo.cursorline = false
      vim.wo.cursorcolumn = false
      return nil
    else
      return nil
    end
  end
  return (require("neoscroll")).setup({cursor_scrolls_alone = true, easing_function = "quadratic", hide_cursor = true, mappings = {"<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb"}, post_hook = _1_, pre_hook = _3_, respect_scrolloff = true, stop_eof = true, use_local_scrolloff = false})
end
return config

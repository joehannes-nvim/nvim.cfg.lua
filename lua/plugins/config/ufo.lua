-- [nfnl] Compiled from fnl/plugins/config/ufo.fnl by https://github.com/Olical/nfnl, do not edit.
local M = {}
M.setup = function()
  vim.o.fillchars = "eob: ,fold: ,foldopen:\239\145\160,foldsep:\226\148\130,foldclose:\239\145\188"
  local function _1_(virt_text, lnum, end_lnum, width, truncate)
    local new_virt_text = {}
    local suffix = (" \239\149\129 %d "):format((end_lnum - lnum))
    local suf_width = vim.fn.strdisplaywidth(suffix)
    local target_width = (width - suf_width)
    local cur_width = 0
    for _, chunk in ipairs(virt_text) do
      local chunk_text = chunk[1]
      local chunk_width = vim.fn.strdisplaywidth(chunk_text)
      if (target_width > (cur_width + chunk_width)) then
        table.insert(new_virt_text, chunk)
      else
        chunk_text = truncate(chunk_text, (target_width - cur_width))
        local hl_group = chunk[2]
        table.insert(new_virt_text, {chunk_text, hl_group})
        chunk_width = vim.fn.strdisplaywidth(chunk_text)
        if ((cur_width + chunk_width) < target_width) then
          suffix = (suffix .. (" "):rep(((target_width - cur_width) - chunk_width)))
        else
        end
        break
      end
      cur_width = (cur_width + chunk_width)
    end
    table.insert(new_virt_text, {suffix, "MoreMsg"})
    return new_virt_text
  end
  local function _4_(bufnr, filetype, buftype)
    return {"treesitter", "indent"}
  end
  return (require("ufo")).setup({enable_get_fold_virt_text = true, fold_virt_text_handler = _1_, open_fold_hl_timeout = 150, preview = {mappings = {scrollD = "<C-d>", scrollU = "<C-u>"}, win_config = {border = {"", "\226\148\128", "", "", "", "\226\148\128", "", ""}, winblend = 0, winhighlight = "Normal:Folded"}}, provider_selector = _4_})
end
return M

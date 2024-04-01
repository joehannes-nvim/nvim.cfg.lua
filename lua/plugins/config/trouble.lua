-- [nfnl] Compiled from fnl/plugins/config/trouble.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  local opts = {action_keys = {cancel = "<esc>", close = "q", close_folds = {"zM", "zm"}, hover = "K", jump = {"<cr>", "<tab>"}, jump_close = {"o"}, next = "j", open_folds = {"zR", "zr"}, open_split = {"<c-x>"}, open_tab = {"<c-t>"}, open_vsplit = {"<c-v>"}, preview = "p", previous = "k", refresh = "r", toggle_fold = {"zA", "za"}, toggle_mode = "m", toggle_preview = "P"}, auto_close = true, auto_jump = {}, auto_open = true, auto_preview = true, fold_closed = "\239\145\160", fold_open = "\239\145\188", group = true, height = 17, icons = true, indent_lines = true, mode = "lsp_references", padding = true, position = "bottom", signs = {error = "\239\153\153", hint = "\239\160\181", information = "\239\145\137", other = "\239\171\160", warning = "\239\148\169"}, width = 50, auto_fold = false, use_diagnostic_signs = false}
  return (require("trouble")).setup(opts)
end
return config

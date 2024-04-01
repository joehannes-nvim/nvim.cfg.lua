-- [nfnl] Compiled from fnl/plugins/core.fnl by https://github.com/Olical/nfnl, do not edit.
local my = _G.my
local function _1_()
  return (require("neodev")).setup({})
end
local function _2_()
  return (require("plugins.config.notify")).setup()
end
local function _3_()
  vim.opt.laststatus = 3
  vim.opt.splitkeep = "screen"
  return nil
end
local function _4_(win)
  return win:hide()
end
local function _5_(win)
  return win:resize("height", 2)
end
local function _6_(win)
  return win:resize("height", ( - 2))
end
local function _7_(win)
  return win:resize("width", ( - 2))
end
local function _8_(win)
  return (win.view.edgebar):equalize()
end
local function _9_(win)
  return win:resize("width", 2)
end
local function _10_(win)
  return (win.view.edgebar):close()
end
local function _11_(win)
  return win:prev({focus = true, pinned = false})
end
local function _12_(win)
  return win:prev({focus = true, visible = true})
end
local function _13_(win)
  return win:next({focus = true, pinned = false})
end
local function _14_(win)
  return win:next({focus = true, visible = true})
end
local function _15_(win)
  return win:close()
end
local function _16_()
  vim.fn.sign_define("DiagnosticSignError", {text = "\239\129\151 ", texthl = "DiagnosticSignError"})
  vim.fn.sign_define("DiagnosticSignWarn", {text = "\239\129\177 ", texthl = "DiagnosticSignWarn"})
  vim.fn.sign_define("DiagnosticSignInfo", {text = "\239\129\154 ", texthl = "DiagnosticSignInfo"})
  vim.fn.sign_define("DiagnosticSignHint", {text = "\243\176\140\181", texthl = "DiagnosticSignHint"})
  return (require("neo-tree")).setup({buffers = {follow_current_file = {enabled = true, leave_dirs_open = false}, group_empty_dirs = true, show_unloaded = true, window = {mappings = {["."] = "set_root", ["<bs>"] = "navigate_up", bd = "buffer_delete", o = {"show_help", config = {prefix_key = "o", title = "Order by"}, nowait = false}, oc = {"order_by_created", nowait = false}, od = {"order_by_diagnostics", nowait = false}, om = {"order_by_modified", nowait = false}, on = {"order_by_name", nowait = false}, os = {"order_by_size", nowait = false}, ot = {"order_by_type", nowait = false}}}}, commands = {}, default_component_configs = {container = {enable_character_fade = true}, created = {enabled = true, required_width = 110}, file_size = {enabled = true, required_width = 64}, git_status = {symbols = {added = "", conflict = "\238\156\167", deleted = "\226\156\150", ignored = "\239\145\180", modified = "", renamed = "\243\176\129\149", staged = "\239\129\134", unstaged = "\243\176\132\177", untracked = "\239\132\168"}}, icon = {default = "*", folder_closed = "\238\151\191", folder_empty = "\243\176\156\140", folder_open = "\238\151\190", highlight = "NeoTreeFileIcon"}, indent = {expander_collapsed = "\239\145\160", expander_expanded = "\239\145\188", expander_highlight = "NeoTreeExpander", highlight = "NeoTreeIndentMarker", indent_marker = "\226\148\130", indent_size = 2, last_indent_marker = "\226\148\148", padding = 1, with_expanders = nil, with_markers = true}, last_modified = {enabled = true, required_width = 88}, modified = {highlight = "NeoTreeModified", symbol = "[+]"}, name = {highlight = "NeoTreeFileName", use_git_status_colors = true, trailing_slash = false}, symlink_target = {enabled = false}, type = {enabled = true, required_width = 122}}, enable_diagnostics = true, enable_git_status = true, filesystem = {commands = {}, filtered_items = {always_show = {}, hide_by_name = {}, hide_by_pattern = {}, hide_gitignored = true, hide_hidden = true, never_show = {}, never_show_by_pattern = {}, hide_dotfiles = false, visible = false}, follow_current_file = {enabled = true, leave_dirs_open = true}, hijack_netrw_behavior = "open_default", use_libuv_file_watcher = true, window = {fuzzy_finder_mappings = {["<C-j>"] = "move_cursor_down", ["<C-k>"] = "move_cursor_up", ["<down>"] = "move_cursor_down", ["<up>"] = "move_cursor_up"}, mappings = {["#"] = "fuzzy_sorter", ["."] = "set_root", ["/"] = "fuzzy_finder", ["<bs>"] = "navigate_up", ["<c-x>"] = "clear_filter", D = "fuzzy_finder_directory", H = "toggle_hidden", ["[g"] = "prev_git_modified", ["]g"] = "next_git_modified", f = "filter_on_submit", o = {"show_help", config = {prefix_key = "o", title = "Order by"}, nowait = false}, oc = {"order_by_created", nowait = false}, od = {"order_by_diagnostics", nowait = false}, og = {"order_by_git_status", nowait = false}, om = {"order_by_modified", nowait = false}, on = {"order_by_name", nowait = false}, os = {"order_by_size", nowait = false}, ot = {"order_by_type", nowait = false}}}, group_empty_dirs = false}, git_status = {window = {mappings = {A = "git_add_all", ga = "git_add_file", gc = "git_commit", gg = "git_commit_and_push", gp = "git_push", gr = "git_revert_file", gu = "git_unstage_file", o = {"show_help", config = {prefix_key = "o", title = "Order by"}, nowait = false}, oc = {"order_by_created", nowait = false}, od = {"order_by_diagnostics", nowait = false}, om = {"order_by_modified", nowait = false}, on = {"order_by_name", nowait = false}, os = {"order_by_size", nowait = false}, ot = {"order_by_type", nowait = false}}, position = "float"}}, nesting_rules = {}, open_files_do_not_replace_types = {"terminal", "trouble", "qf"}, popup_border_style = "rounded", sort_function = nil, window = {mapping_options = {noremap = true, nowait = true}, mappings = {["<"] = "prev_source", ["<2-LeftMouse>"] = "open", ["<cr>"] = "open", ["<esc>"] = "cancel", ["<space>"] = {"toggle_node", nowait = false}, [">"] = "next_source", ["?"] = "show_help", A = "add_directory", C = "close_node", P = {"toggle_preview", config = {use_float = true, use_image_nvim = true}}, R = "refresh", S = "open_split", a = {"add", config = {show_path = "none"}}, c = "copy", d = "delete", i = "show_file_details", l = "focus_preview", m = "move", p = "paste_from_clipboard", q = "close_window", r = "rename", s = "open_vsplit", t = "open_tabnew", w = "open_with_window_picker", x = "cut_to_clipboard", y = "copy_to_clipboard", z = "close_all_nodes"}, position = "left", width = 37}, close_if_last_window = false, enable_normal_mode_for_inputs = false, sort_case_insensitive = false})
end
local function _17_()
  return (require("window-picker")).setup({filter_rules = {autoselect_one = true, bo = {buftype = {"terminal", "quickfix"}, filetype = {"neo-tree", "neo-tree-popup", "notify"}}, include_current_win = false}})
end
local function _18_()
  return (require("switchpanel")).setup({builtin = {"neotree-files", "neotree-gitstatus", "neotree-buffers", "undotree"}, focus_on_open = true, panel_list = {background = "Silver", color = "Black", selected = "Gold", show = false}, tab_repeat = true, width = 30})
end
local function _19_()
  return (require("plugins.config.statuscol")).setup()
end
local function _20_()
  local function _21_()
  end
  return (require("persisted")).setup({allowed_dirs = nil, autosave = true, follow_cwd = true, ignored_dirs = nil, on_autoload_no_session = _21_, save_dir = vim.fn.expand((vim.fn.stdpath("data") .. "/sessions/")), should_autosave = nil, silent = true, telescope = {reset_prompt_after_deletion = true}, use_git_branch = true, autoload = false})
end
local function _22_()
  return (require("pretty-fold")).setup()
end
local function _23_()
  return (require("plugins.config.noice")).setup()
end
local function _24_()
  return (require("plugins.config.scroll")).setup()
end
local function _25_()
  local function _26_(t)
    return my.ui.removeTerminal(t)
  end
  local function _27_(t)
    my.ui.addTerminal(t)
    return vim.cmd("startinsert!")
  end
  local function _28_(term)
    if (term.direction == "horizontal") then
      return 17
    elseif (term.direction == "vertical") then
      return (vim.o.columns * 0.4)
    else
      return nil
    end
  end
  local function _30_(term)
    return term.name
  end
  return (require("toggleterm")).setup({auto_scroll = true, autochdir = true, close_on_exit = true, direction = "horizontal", float_opts = {border = "curved", height = math.ceil((vim.o.lines * 0.9)), width = vim.o.columns, winblend = 5}, hide_numbers = true, highlights = {FloatBorder = {guibg = "NONE", guifg = my.color.my.magenta, Normal = {guibg = my.color.hsl(my.color.my[(vim.opt.background):get()]).mix(my.color.hsl(my.color.my.vimode[(vim.fn.mode() or "n")]), 21)}, NormalFloat = {link = "Normal"}, insert_mappings = true, on_exit = _26_, on_open = _27_, persist_mode = true, persist_size = true, shade_filetypes = {}, shade_terminals = true, shading_factor = ( - 21), shell = vim.o.shell, size = _28_, start_in_insert = true, terminal_mappings = true, winbar = {enabled = true, name_formatter = _30_}}}})
end
local function _31_()
  return (require("document-color")).setup({mode = "background"})
end
local function _32_()
  return (require("project_nvim")).setup({detection_methods = {"pattern"}})
end
local function _33_()
  return (require("neogen")).setup({enabled = true, input_after_comment = true, languages = {javascript = {template = {annotation_convention = "jsdoc"}}, javascriptreact = {template = {annotation_convention = "jsdoc"}}, typescript = {template = {annotation_convention = "tsdoc"}}, typescriptreact = {template = {annotation_convention = "tsdoc"}}}})
end
return {{"Olical/nfnl"}, {"folke/neodev.nvim", config = _1_, opts = {}}, {"nvim-lua/plenary.nvim"}, {"stevearc/dressing.nvim"}, {"MunifTanjim/nui.nvim"}, {"rcarriga/nvim-notify", config = _2_, event = "VimEnter"}, {"nvim-lua/popup.nvim"}, {"folke/edgy.nvim", event = "VeryLazy", init = _3_, opts = {keys = {["<c-q>"] = _4_, ["<c-w>+"] = _5_, ["<c-w>-"] = _6_, ["<c-w><lt>"] = _7_, ["<c-w>="] = _8_, ["<c-w>>"] = _9_, Q = _10_, ["[W"] = _11_, ["[L"] = _12_, ["]W"] = _13_, ["]L"] = _14_, q = _15_}, left = {{title = "GitFiles", ft = "sidebar-nvim", pinned = true, open = "SidebarNvimToggle"}, {title = "FileTree", ft = "filetree", open = "NvimTreeToggle"}}, right = {{title = "OGPT Popup", ft = "ogpt-popup", size = {width = 0.2}, wo = {wrap = true}}, {title = "OGPT Parameters", ft = "ogpt-parameters-window", size = {height = 6}, wo = {wrap = true}}, {title = "OGPT Template", ft = "ogpt-template", size = {height = 6}}, {title = "OGPT Sesssions", ft = "ogpt-sessions", size = {height = 6}, wo = {wrap = true}}, {title = "OGPT System Input", ft = "ogpt-system-window", size = {height = 6}}, {title = "OGPT", ft = "ogpt-window", size = {height = 0.5}, wo = {wrap = true}}, {title = "OGPT {{selection}}", ft = "ogpt-selection", size = {width = 80, height = 4}, wo = {wrap = true}}, {title = "OGPt {{instruction}}", ft = "ogpt-instruction", size = {width = 80, height = 4}, wo = {wrap = true}}, {title = "OGPT Chat", ft = "ogpt-input", size = {width = 80, height = 4}, wo = {wrap = true}}}}}, {"mbbill/undotree"}, {"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", config = _16_, requires = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim"}}, {"s1n7ax/nvim-window-picker", config = _17_, version = "2.*"}, {"joehannes-nvim/switchpanel.nvim", config = _18_}, {"luukvbaal/statuscol.nvim", config = _19_}, {"nathom/filetype.nvim"}, {"olimorris/persisted.nvim", config = _20_}, {"tversteeg/registers.nvim"}, {"anuvyklack/pretty-fold.nvim", config = _22_}, {"folke/noice.nvim", event = "VeryLazy", opts = {}, dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"}, config = _23_}, {"indianboy42/hop-extensions"}, {"karb94/neoscroll.nvim", config = _24_}, {"akinsho/toggleterm.nvim", config = _25_}, {"rolv-apneseth/tfm.nvim", opts = {file_manager = "yazi", replace_netrw = true, enable_cmds = true, keybindings = {["<ESC>"] = "q"}, ui = {border = "rounded", height = 0.9, width = 1, x = 0, y = 0}}, lazy = false}, {"lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {}}, {"mrshmllow/document-color.nvim", config = _31_}, {"mhinz/vim-grepper"}, {"ahmedkhalf/project.nvim", config = _32_}, {"danymat/neogen", config = _33_, dependencies = "nvim-treesitter/nvim-treesitter"}}

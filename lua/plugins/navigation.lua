-- [nfnl] Compiled from fnl/plugins/navigation.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("marks")).setup({bookmark_0 = {sign = "\239\128\174", virt_text = " (\239\128\174 0) "}, bookmark_1 = {sign = "\239\128\174", virt_text = " (\239\128\174 1) "}, bookmark_2 = {sign = "\239\128\174", virt_text = " (\239\128\174 2) "}, bookmark_3 = {sign = "\239\128\174", virt_text = " (\239\128\174 3) "}, bookmark_4 = {sign = "\239\128\174", virt_text = " (\239\128\174 4) "}, bookmark_5 = {sign = "\239\128\174", virt_text = " (\239\128\174 5) "}, bookmark_6 = {sign = "\239\128\174", virt_text = " (\239\128\174 6) "}, bookmark_7 = {sign = "\239\128\174", virt_text = " (\239\128\174 7) "}, bookmark_8 = {sign = "\239\128\174", virt_text = " (\239\128\174 8) "}, bookmark_9 = {sign = "\239\128\174", virt_text = " (\239\128\174 9) "}, default_mappings = true, mappings = {annotate = "m@", m3 = false, m9 = false, m1 = false, m2 = false, m6 = false, m8 = false, m4 = false, m0 = false, m7 = false, m5 = false}})
end
local function _2_()
  return (require("plugins.config.portal")).setup()
end
local function _3_()
  local hop = require("hop")
  local directions = (require("hop.hint")).HintDirection
  hop.setup({keys = "etovxqpdygfblzhckisuran"})
  local function _4_()
    return hop.hint_char1({current_line_only = true, direction = directions.AFTER_CURSOR})
  end
  vim.keymap.set("", "f", _4_, {remap = true})
  local function _5_()
    return hop.hint_char1({current_line_only = true, direction = directions.BEFORE_CURSOR})
  end
  vim.keymap.set("", "F", _5_, {remap = true})
  local function _6_()
    return hop.hint_char1({current_line_only = true, direction = directions.AFTER_CURSOR, hint_offset = ( - 1)})
  end
  vim.keymap.set("", "t", _6_, {remap = true})
  local function _7_()
    return hop.hint_char1({current_line_only = true, direction = directions.BEFORE_CURSOR, hint_offset = 1})
  end
  return vim.keymap.set("", "T", _7_, {remap = true})
end
local function _8_()
  return (require("plugins.config.navbuddy")).setup()
end
local function _9_()
  return (require("trailblazer")).setup({{auto_load_trailblazer_state_on_enter = true, auto_save_trailblazer_state_on_exit = true, custom_session_storage_dir = "~/.local/share/nvim/sessions/", event_list = {}, lang = "en", mappings = {nv = {actions = {}, motions = {}}}, quickfix_mappings = {nv = {actions = {qf_action_delete_trail_mark_selection = "d", qf_action_save_visual_selection_start_line = "v"}, alt_actions = {qf_action_save_visual_selection_start_line = "V"}, motions = {qf_motion_move_trail_mark_stack_cursor = "<CR>"}}, v = {actions = {qf_action_move_selected_trail_marks_down = "<C-j>", qf_action_move_selected_trail_marks_up = "<C-k>"}}}, trail_options = {available_trail_mark_modes = {"global_chron", "global_buf_line_sorted", "global_fpath_line_sorted", "global_chron_buf_line_sorted", "global_chron_fpath_line_sorted", "global_chron_buf_switch_group_chron", "global_chron_buf_switch_group_line_sorted", "buffer_local_chron", "buffer_local_line_sorted"}, available_trail_mark_stack_sort_modes = {"alpha_asc", "alpha_dsc", "chron_asc", "chron_dsc"}, current_trail_mark_list_type = "quickfix", current_trail_mark_mode = "global_chron", current_trail_mark_stack_sort_mode = "chron_asc", cursor_mark_symbol = "\226\166\129", default_trail_mark_stacks = {"default"}, mark_symbol = "\226\128\162", move_to_nearest_before_peek_dist_type = "lin_char_dist", move_to_nearest_before_peek_motion_directive_down = "fpath_down", move_to_nearest_before_peek_motion_directive_up = "fpath_up", multiple_mark_symbol_counters_enabled = true, newest_mark_symbol = "\240\159\148\165", next_mark_symbol = "\226\164\183", number_line_color_enabled = true, previous_mark_symbol = "\226\164\182", symbol_line_enabled = true, trail_mark_in_text_highlights_enabled = true, trail_mark_list_rows = 10, trail_mark_priority = 10001, verbose_trail_mark_select = true, trail_mark_symbol_line_indicators_enabled = false, move_to_nearest_before_peek = false}}})
end
return {{"chentoast/marks.nvim", config = _1_}, {"cbochs/portal.nvim", config = _2_, dependencies = {"cbochs/grapple.nvim", "ThePrimeagen/harpoon"}}, {"phaazon/hop.nvim", as = "hop", branch = "v2", config = _3_}, {"SmiteshP/nvim-navbuddy", config = _8_, dependencies = {"neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim", "nvim-telescope/telescope.nvim"}}, {"LeonHeidelbach/trailblazer.nvim", config = _9_}}

(local M {})

(fn M.onAfterBoot [opts]
  (my.ui.tint)
  (my.ui.updateHighlights))

(fn M.onColorScheme []
  (my.ui.updateHighlights)
  (my.ui.tint)
  (vim.cmd "set cursorline")
  (vim.cmd "set cursorcolumn"))
  ; (vim.api.nvim_set_var :neovide_background_color
  ;                       (.. (. my.color.my.vimode (vim.fn.mode))
  ;                           (my.color.fn.transparentizeColor))))

(fn M.onModeChanged []
  (my.ui.tint)
  (my.ui.updateHighlights))
  ; (vim.api.nvim_set_hl 0
  ;                      :TabLineSel
  ;                      {:bg (. my.color.my.vimode (vim.fn.mode)) :fg my.color.my.theme.bold-retro.primary :nocombine false})

(fn M.grepAndOpen []
  (vim.ui.input {:prompt "Enter pattern: "}
                (fn [pattern]
                  (when (not= pattern nil)
                    (vim.cmd (.. "silent grep! " pattern))
                    (vim.cmd "Trouble quickfix")))))

(fn M.toggle_bg_mode [force]
  (let [current (vim.opt.background:get)
        other (or (and (= current :light) :dark) :light)]
    (vim.api.nvim_set_option :background (or (and force current) other))
    (my.ui.updateHighlights)
    (my.ui.tint)))

(fn M.applyWinSeparatorNCHighlight []
  (let [ns-winsep (vim.api.nvim_create_namespace :CurrentBuffer)]
    (vim.api.nvim_set_hl_ns ns-winsep)
    (vim.api.nvim_set_hl 0 :WinSeparator
                         {:bg :bg :fg my.color.my.aqua :nocombine false})))

(fn M.activate_current_win_sep []
  (let [ns-winsep (vim.api.nvim_create_namespace :CurrentBuffer)]
    (vim.api.nvim_set_hl ns-winsep :WinSeparator
                         {:bg my.color.my.magenta :fg my.color.my.aqua})))

(fn M.clear_current_win_sep []
  (let [ns-winsep (vim.api.nvim_create_namespace :CurrentBuffer)]
    (vim.api.nvim_buf_clear_namespace 0 ns-winsep 0 (- 1))))

M

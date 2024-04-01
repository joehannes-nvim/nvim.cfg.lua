(local M {})

(fn M.qftf [info]
  (var items nil)
  (local ret {})
  (if (= info.quickfix 1) (set items
                               (. (vim.fn.getqflist {:id info.id :items 0})
                                  :items))
      (set items (. (vim.fn.getloclist info.winid {:id info.id :items 0})
                    :items)))
  (local limit 31)
  (local (fname-fmt1 fname-fmt2)
         (values (.. "%-" limit :s) (.. "…%." (- limit 1) :s)))
  (local valid-fmt "%s │%5d:%-3d│%s %s")
  (for [i info.start_idx info.end_idx]
    (local e (. items i))
    (var fname "")
    (var str nil)
    (when (= e nil) (lua :break))
    (if (= e.valid 1)
        (do
          (when (> e.bufnr 0)
            (set fname (vim.fn.bufname e.bufnr))
            (if (= fname "") (set fname "[No Name]")
                (set fname (fname:gsub (.. "^" vim.env.HOME) "~")))
            (if (<= (length fname) limit) (set fname (fname-fmt1:format fname))
                (set fname (fname-fmt2:format (fname:sub (- 1 limit))))))
          (local lnum (or (and (> e.lnum 99999) (- 1)) e.lnum))
          (local col (or (and (> e.col 999) (- 1)) e.col))
          (local qtype
                 (or (and (= e.type "") "")
                     (.. " " (: (e.type:sub 1 1) :upper))))
          (set str (valid-fmt:format fname lnum col qtype e.text)))
        (set str e.text))
    (table.insert ret str))
  ret)

(fn M.tint []
  (fn vimode-color [] (. my.color.my.vimode (vim.fn.mode)))
  (fn secondary-vimode-color []
    (my.color.fn.background_blend (vimode-color) 70))
  (fn tertiary-vimode-color [] (my.color.fn.background_blend (vimode-color) 21))
  (local (ok tint) (pcall require :tint))
  (local lines (require :heirline))
  (local heirline (require :plugins.config.heirline))
  (when ok
    (tint.refresh)
    (heirline.update)
    (heirline.setup false)))
  ; (vim.api.nvim_set_hl 0 :Normal
  ;                        {:bg (my.color.fn.background_blend (. my.color.my.vimode (vim.fn.mode)) 10)})

(fn M.updateHighlights []
  (let [mode-color (. my.color.my.vimode (vim.fn.mode))]
    (fn secondary-vimode-color [] (my.color.fn.background_blend mode-color 50))

    (fn tertiary-vimode-color [] (my.color.fn.background_blend mode-color 21))

    (each [def-color git-signs-hl (pairs {(. (my.color.theme my.color.my.current-theme) :flow) :GitSignsAdd
                                          (. (my.color.theme my.color.my.current-theme) :normal) :GitSignsChange
                                          (. (my.color.theme my.color.my.current-theme) :attention) :GitSignsDelete})]
      ; (my.color.fn.highlight_blend_bg git-signs-hl 21 def-color)
      (my.color.fn.highlight_blend_bg (.. git-signs-hl :Nr) 50 def-color)
      (my.color.fn.highlight_blend_bg (.. git-signs-hl :Ln) 70 def-color))
    (my.color.fn.highlight_blend_bg :CursorLine 37 mode-color)
    (my.color.fn.highlight_blend_bg :CursorColumn 37 mode-color)
    (my.color.fn.highlight_blend_bg :Visual 37 (. (my.color.theme my.color.my.current-theme) :primary)
        (my.color.fn.highlight_blend_bg :TSCurrentScope 10 mode-color)
        (my.color.fn.highlight_blend_bg :TreesitterContext 21 mode-color)
        (vim.api.nvim_set_hl 0 :TreesitterContextBottom
                             {:fg (. (my.color.theme my.color.my.current-theme) :primary)
                              :sp (. (my.color.theme my.color.my.current-theme) :attention)
                              :underdouble true
                              :underline true})
        (vim.api.nvim_set_hl 0 :ScrollbarHandle {:bg mode-color}))))

(fn M.tablinePickBuffer []
  (let [tabline (. (require :heirline) :tabline)
        buflist (. tabline._buflist 1)]
    (set buflist._picker_labels {})
    (set buflist._show_picker true)
    (vim.cmd.redrawtabline)
    (local char (vim.fn.getcharstr))
    (local bufnr (. buflist._picker_labels char))
    (when bufnr (vim.api.nvim_win_set_buf 0 bufnr))
    (set buflist._show_picker false)
    (vim.cmd.redrawtabline)))

(fn M.toggleSidebar [which]
  (vim.cmd (.. "SwitchPanelSwitch " which))
  ((. (require :switchpanel.panel_list) :close)))

(set _G._G.TERMINAL_CURRENT nil)
(set _G._G.TERMINAL_LIST {})
(fn M.cycleTerminal [direction]
  (when (< (length _G.TERMINAL_LIST) 2) (lua "return "))
  (var terminal-next nil)
  (if direction (do
                  (each [_ val (pairs _G.TERMINAL_LIST)]
                    (when (> val _G.TERMINAL_CURRENT) (set terminal-next val)
                      (lua :break)))
                  (when (not terminal-next)
                    (set terminal-next (. _G.TERMINAL_LIST 0))))
      (not direction)
      (do
        (each [_ val (pairs _G.TERMINAL_LIST)]
          (if (>= val _G.TERMINAL_CURRENT) (lua :break) (set terminal-next val)))
        (when (not terminal-next)
          (set terminal-next (. _G.TERMINAL_LIST (length _G.TERMINAL_LIST))))))
  (vim.cmd (.. terminal-next :ToggleTerm)))
(fn M.addTerminal [nr]
  (var idx (- 1))
  (var sel-val nil)
  (each [key val (pairs _G.TERMINAL_LIST)]
    (when (<= nr.id val) (set idx key) (set sel-val val) (lua :break)))
  (when (= sel-val nr.id) (lua "return 0"))
  (when (= idx (- 1)) (set idx (length _G.TERMINAL_LIST)))
  (table.insert _G.TERMINAL_LIST idx nr.id)
  (global TERMINAL_CURRENT nr.id)
  idx)
(fn M.removeTerminal [nr]
  (var idx 0)
  (each [key val (pairs _G.TERMINAL_LIST)]
    (when (= nr.id val) (set idx key) (lua :break))
    (table.remove _G.TERMINAL_LIST idx))
  (when (= _G.TERMINAL_CURRENT nr.id) (global TERMINAL_CURRENT nil)))
(fn M.openTerminal [nr]
  (set-forcibly! nr (or (or nr vim.v.count1) 1))
  (vim.cmd (.. nr "ToggleTerm direction='float'")))

(fn M.lineDiagnostics []
  (each [_ winid (pairs (vim.api.nvim_tabpage_list_wins 0))]
    (when (. (vim.api.nvim_win_get_config winid) :zindex) (lua "return ")))
  (vim.diagnostic.open_float 0 {:close_events [:CursorMoved
                                               :CursorMovedI
                                               :BufHidden
                                               :InsertCharPre
                                               :WinLeave]
                                :focusable false
                                :scope :cursor}))

(fn M.set-cursor-ns []
  (vim.api.nvim_create_namespace "my_cursor"))

(fn M.clear-cursor-ns! []
  (let [my_ns (. (vim.api.nvim_get_namespaces) "my_cursor")]
    (when (not (= nil my_ns))
      (vim.api.nvim_buf_clear_namespace 0 (. (vim.api.nvim_get_namespaces) "my_cursor") 1 -1)))
  (vim.api.nvim_create_namespace "my_cursor"))

(fn M.set-cursor-hl []
  (let [cursor (vim.api.nvim_win_get_cursor 0)
        height (vim.api.nvim_win_get_height 0)
        my_ns (. (vim.api.nvim_get_namespaces) "my_cursor")]
    (vim.api.nvim_get_hl my_ns {:name "MyCursorHL" :create true})
    (vim.api.nvim_set_hl
      0
      "MyCursorHL"
      {:bg (. my.color.my.vimode (vim.fn.mode))
       :force true})
    (vim.highlight.range 0 my_ns "MyCursorHL" [(. cursor 1) 1] [(. cursor 1) -1] {:priority 65535})
    (vim.api.nvim_buf_add_highlight 0 my_ns "MyCursorHL" (. cursor 1) 1 -1)
    (for [i 1 height 1]
      (vim.api.nvim_buf_add_highlight 0 my_ns "MyCursorHL" i (. cursor 2) (+ 1 (. cursor 2)))
      (vim.highlight.range 0 my_ns "MyCursorHL" [i (. cursor 2)] [i (+ 1 (. cursor 2))] {:priority 65535}))))

M


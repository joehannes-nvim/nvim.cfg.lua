; ### AstroNvim Status Environment
;
; Statusline related environment variables shared between components/providers/etc.
;
; This module can be loaded with `local env = require "_G.my.astro.utils.status.env"`
;
; @module _G.my.astro.utils.status.env
; @copyright 2023
; @license GNU General Public License v3.0

(local M {})
(set M.fallback_colors {:bg "#1e222a"
                        :blue "#61afef"
                        :bright_grey "#777d86"
                        :bright_purple "#a9a1e1"
                        :bright_red "#ec5f67"
                        :bright_yellow "#ebae34"
                        :dark_bg "#2c323c"
                        :dark_grey "#5c5c5c"
                        :fg "#abb2bf"
                        :green "#98c379"
                        :grey "#5c6370"
                        :none :NONE
                        :orange "#ff9640"
                        :purple "#c678dd"
                        :red "#e06c75"
                        :white "#c9c9c9"
                        :yellow "#e5c07b"})
(set M.modes {"\019" [:BLOCK :visual]
              "\022" [:BLOCK :visual]
              "\022s" [:BLOCK :visual]
              :! [:SHELL :inactive]
              :R [:REPLACE :replace]
              :Rc [:REPLACE :replace]
              :Rv [:V-REPLACE :replace]
              :Rx [:REPLACE :replace]
              :S [:SELECT :visual]
              :V [:LINES :visual]
              :Vs [:LINES :visual]
              :c [:COMMAND :command]
              :ce [:COMMAND :command]
              :cv [:COMMAND :command]
              :i [:INSERT :insert]
              :ic [:INSERT :insert]
              :ix [:INSERT :insert]
              :n [:NORMAL :normal]
              :niI [:NORMAL :normal]
              :niR [:NORMAL :normal]
              :niV [:NORMAL :normal]
              :no [:OP :normal]
              "no\022" [:OP :normal]
              :noV [:OP :normal]
              :nov [:OP :normal]
              :nt [:TERM :terminal]
              :null [:null :inactive]
              :r [:PROMPT :inactive]
              :r? [:CONFIRM :inactive]
              :rm [:MORE :inactive]
              :s [:SELECT :visual]
              :t [:TERM :terminal]
              :v [:VISUAL :visual]
              :vs [:VISUAL :visual]})
(set M.separators (_G.my.astro.user_opts :heirline.separators
                                       {:breadcrumbs "  "
                                        :center ["  " "  "]
                                        :left ["" "  "]
                                        :none ["" ""]
                                        :path "  "
                                        :right ["  " ""]
                                        :tab ["" " "]}))
(set M.attributes
     (_G.my.astro.user_opts :heirline.attributes
                          {:buffer_active {:bold true :italic true}
                           :buffer_picker {:bold true}
                           :git_branch {:bold true}
                           :git_diff {:bold true}
                           :macro_recording {:bold true}}))
(set M.icon_highlights
     (_G.my.astro.user_opts :heirline.icon_highlights
                          {:file_icon {:statusline true
                                       :tabline (fn [self]
                                                  (or self.is_active
                                                      self.is_visible))}}))
(fn pattern-match [str pattern-list]
  (each [_ pattern (ipairs pattern-list)]
    (when (str:find pattern) (lua "return true")))
  false)
(set M.buf_matchers
     {:bufname (fn [pattern-list bufnr]
                 (pattern-match (vim.fn.fnamemodify (vim.api.nvim_buf_get_name (or bufnr
                                                                                   0))
                                                    ":t")
                                pattern-list))
      :buftype (fn [pattern-list bufnr]
                 (pattern-match (. (. vim.bo (or bufnr 0)) :buftype)
                                pattern-list))
      :filetype (fn [pattern-list bufnr]
                  (pattern-match (. (. vim.bo (or bufnr 0)) :filetype)
                                 pattern-list))})
(set M.sign_handlers {})
(fn gitsigns [_]
  (let [(gitsigns-avail gitsigns) (pcall require :gitsigns)]
    (when gitsigns-avail (vim.schedule gitsigns.preview_hunk))))
(each [_ sign (ipairs [:Topdelete :Untracked :Add :Changedelete :Delete])]
  (local name (.. :GitSigns sign))
  (when (not (. M.sign_handlers name)) (tset M.sign_handlers name gitsigns)))
(fn diagnostics [args]
  (if (args.mods:find :c) (vim.schedule vim.lsp.buf.code_action)
      (vim.schedule vim.diagnostic.open_float)))
(each [_ sign (ipairs [:Error :Hint :Info :Warn])]
  (local name (.. :DiagnosticSign sign))
  (when (not (. M.sign_handlers name)) (tset M.sign_handlers name diagnostics)))
(fn dap-breakpoint [_]
  (let [(dap-avail dap) (pcall require :dap)]
    (when dap-avail (vim.schedule dap.toggle_breakpoint))))
(each [_ sign (ipairs ["" :Rejected :Condition])]
  (local name (.. :DapBreakpoint sign))
  (when (not (. M.sign_handlers name))
    (tset M.sign_handlers name dap-breakpoint)))
(set M.sign_handlers (_G.my.astro.user_opts :heirline.sign_handlers
                                          M.sign_handlers))
M

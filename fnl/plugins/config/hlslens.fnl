(local M {})

(fn M.setup []
  ((. (require :hlslens) :setup) {:auto_enable true
                                  :build_position_cb nil
                                  :calm_down false
                                  :enable_incsearch true
                                  :float_shadow_blend 50
                                  :nearest_float_when :auto
                                  :nearest_only false
                                  :override_lens nil
                                  :virt_priority 100})
  (vim.cmd "    hi default link HlSearchNear IncSearch
    hi default link HlSearchLens WildMenu
    hi default link HlSearchLensNear IncSearch
    hi default link HlSearchFloat IncSearch
  "))

M


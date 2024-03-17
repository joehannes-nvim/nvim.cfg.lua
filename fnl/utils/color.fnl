(local M
       {:fn {}
        :hex_to_rgb (fn [...]
                      ((. (require :lush.vivid.rgb.convert) :hex_to_rgb) ...))
        :hsl (fn [color]
               ((. (require :lush) :hsl) color))
        :hsluv (fn [color]
                 ((. (require :lush) :hsluv) color))
        :int_to_hex (fn [color] (.. "#" (string.format "%06x" color)))
        :my {:aqua "#00DFFF"
             :blue "#0000FF"
             :dark "#100710"
             :green "#00FF80"
             :light "#F0FFFD"
             :magenta "#F634B1"
             :orange "#FFAF00"
             :purple "#A000FF"
             :red "#FF0080"
             :yellow "#FFDF00"
             :theme {:bold-retro {:primary  "#F7DE81" ; orange-toned gold
                                  :secondary "#595959"  ; dark, vintage silver
                                  :normal "#00FFEF" ;electric aqua
                                  :attention "#C71585" ;neon-tinged crimson
                                  :command "#800080" ;true, vibrant purple
                                  :flow "#00FA9A"}}} ;medium spring green
        :rgb_to_hex (fn [...]
                      ((. (require :lush.vivid.rgb.convert) :rgb_to_hex) ...))})

(set M.my.vimode {"\019" M.my.theme.bold-retro.primary
                  "\022" M.my.theme.bold-retro.primary
                  :! M.my.theme.bold-retro.command
                  :R M.my.theme.bold-retro.attention
                  :Rv M.my.theme.bold-retro.attention
                  :S M.my.theme.bold-retro.attention
                  :V M.my.theme.bold-retro.primary
                  :c M.my.theme.bold-retro.command
                  :ce M.my.theme.bold-retro.command
                  :cv M.my.theme.bold-retro.command
                  :i M.my.theme.bold-retro.flow
                  :ic M.my.theme.bold-retro.flow
                  :n M.my.theme.bold-retro.secondary
                  :no M.my.theme.bold-retro.command
                  :r M.my.theme.bold-retro.attention
                  :r? M.my.theme.bold-retro.attention
                  :rm M.my.theme.bold-retro.attention
                  :s M.my.theme.bold-retro.attention
                  :t M.my.theme.bold-retro.command
                  :v M.my.theme.bold-retro.primary})

(fn M.fn.background_blend [color strength hl]
  (global Bg-color nil)
  (local (status hl-cfg) (pcall (fn [] (vim.api.nvim_get_hl_by_name hl true))))
  (if (and hl status) (global Bg-color
                              (or hl-cfg.background
                                  (. (vim.api.nvim_get_hl_by_name :NormalNC
                                                                  true)
                                     :background)))
      (global Bg-color (. (vim.api.nvim_get_hl_by_name :Normal true)
                          :background)))
  (local blend-color (M.hsl color))
  (local base-color
         (or (and Bg-color (M.int_to_hex Bg-color))
             (. my.color.my (vim.opt.background:get))))
  (. ((. (M.hsl base-color) :mix) blend-color strength) :hex))

(fn M.fn.highlight_blend_bg [hl-name strength color base-hl]
  (set-forcibly! base-hl (or base-hl :MyNormal))
  (var old-hl nil)

  (fn fetch-old-hl []
    (when (= color nil)
      (local _old-hl (vim.api.nvim_get_hl_by_name base-hl true))
      (local target-old-hl (vim.api.nvim_get_hl_by_name hl-name true))
      (set old-hl
           (or (and _old-hl _old-hl.background)
               (and target-old-hl target-old-hl.background)))))

  (when (or (pcall fetch-old-hl) color)
    (local hl-guibg
           (M.fn.background_blend (or (or color
                                          (and old-hl (M.int_to_hex old-hl)))
                                      (. my.color.my (vim.opt.background:get)))
                                  strength :MyNormal))
    (vim.api.nvim_set_hl 0 hl-name {:background hl-guibg :nocombine false :force true})))

(fn M.fn.transparentizeColor []
  (string.format "%x" (math.floor (* 255 (or vim.g.transparency 0.8)))))

(set M.util
     {:darken (fn [hex-color percentage]
                (. ((. (M.hsl hex-color) :darken) percentage) :hex))
      :desaturate (fn [hex-color percentage]
                    (. ((. (M.hsl hex-color) :desaturate) percentage) :hex))
      :lighten (fn [hex-color percentage]
                 (. ((. (M.hsl hex-color) :lighten) percentage) :hex))
      :saturate (fn [hex-color percentage]
                  (. ((. (M.hsl hex-color) :saturate) percentage) :hex))})

M


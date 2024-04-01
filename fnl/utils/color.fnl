(var M {})
(fn M.theme [t]
  (let [t! (or t M.my.current-theme)]
    (. M.my.theme t!)))
(set M (vim.tbl_extend "keep" M
                              {:fn {}
                               :hex_to_rgb (fn [...]
                                             ((. (require :lush.vivid.rgb.convert) :hex_to_rgb) ...))
                               :hsl (fn [color] ((. (require :lush) :hsl) color))
                               :hsluv (fn [color] ((. (require :lush) :hsluv) color))
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
                                    :current-theme "lush"
                                    :theme {:bold-retro {:primary  "#F7DE81" ; orange-toned gold
                                                         :secondary "#595959"  ; dark, vintage silver
                                                         :normal "#00FFEF" ;electric aqua
                                                         :attention "#C71585" ;neon-tinged crimson
                                                         :command "#800080" ;true, vibrant purple
                                                         :flow "#00FA9A"}
                                            :lush {:primary "#500050"
                                                   :secondary "#D7BE51"
                                                   :normal "#A000FF"
                                                   :attention "#FF0080"
                                                   :command "#D7BE81" ;medium spring green
                                                   :flow "#00FF80"}}}
                               :rgb_to_hex (fn [...]
                                             ((. (require :lush.vivid.rgb.convert) :rgb_to_hex) ...))}))

(set M.my.vimode {"\019" (. (M.theme M.current-theme) :normal)
                  "\022" (. (M.theme M.current-theme) :normal)
                  :! (. (M.theme M.current-theme) :command)
                  :R (. (M.theme M.current-theme) :attention)
                  :Rv (. (M.theme M.current-theme) :attention)
                  :S (. (M.theme M.current-theme) :attention)
                  :V (. (M.theme M.current-theme) :primary)
                  :c (. (M.theme M.current-theme) :command)
                  :ce (. (M.theme M.current-theme) :command)
                  :cv (. (M.theme M.current-theme) :command)
                  :i (. (M.theme M.current-theme) :flow)
                  :ic (. (M.theme M.current-theme) :flow)
                  :n (. (M.theme M.current-theme) :secondary)
                  :no (. (M.theme M.current-theme) :command)
                  :r (. (M.theme M.current-theme) :attention)
                  :r? (. (M.theme M.current-theme) :attention)
                  :rm (. (M.theme M.current-theme) :attention)
                  :s (. (M.theme M.current-theme) :attention)
                  :t (. (M.theme M.current-theme) :command)
                  :v (. (M.theme M.current-theme) :normal)})

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


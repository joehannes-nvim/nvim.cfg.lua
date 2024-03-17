(local config {})

(fn config.setup []
  (let [notify (require :notify)]
    (notify.setup {:background_colour (fn []
                                        (var output "#F634B1")
                                        (if (= (vim.opt.background:get) :light)
                                            (set output "#F737C7")
                                            (set output "#F73090"))
                                        output)
                   :icons {:DEBUG ""
                           :ERROR ""
                           :INFO ""
                           :TRACE "✎"
                           :WARN ""}
                   :minimum_width 70
                   :render :default
                   :stages :fade
                   :timeout 7000})
    (set vim.notify notify)))

config


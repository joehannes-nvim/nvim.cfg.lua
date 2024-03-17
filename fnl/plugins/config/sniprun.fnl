(local M {})

(fn M.setup []
  ((. (require :sniprun) :setup) {:display [:VirtualTextOk
                                            :VirtualTextErr
                                            :LongTempFloatingWindow]}))

M


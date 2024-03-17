(local M {})

(fn M.setup []
  ((. (require :portal) :setup) {:jump {:keys {:backward :<c-o>
                                               :forward :<c-i>}
                                        :labels {:escape {:<esc> true}
                                                 :select [:j :k :h :l]}
                                        :query [:modified :different :valid]}
                                 :window {:portal {:options {:border :single
                                                             :col 2
                                                             :focusable false
                                                             :height 3
                                                             :noautocmd true
                                                             :relative :cursor
                                                             :width 80
                                                             :zindex 99}
                                                   :render_empty false}
                                          :title {:options {:border :single
                                                            :col 2
                                                            :focusable false
                                                            :height 1
                                                            :noautocmd true
                                                            :relative :cursor
                                                            :style :minimal
                                                            :width 80
                                                            :zindex 98}
                                                  :render_empty true}}}))

M


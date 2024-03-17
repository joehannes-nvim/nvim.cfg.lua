(local M {})

(fn M.setup []
  ((. (require :themer) :setup) {:dim_inactive true
                                 :enable_installer true
                                 :remaps {:highlights {:globals {:cursorlinenr {:underline false}}}}
                                 :styles {:comment {}
                                          :conditional {:style :bold}
                                          :function {:style "bold,italic"}
                                          :functionBuiltIn {:style "italic,bold"}
                                          :include {:style :bold}
                                          :keyword {:style :bold}
                                          :keywordBuiltIn {:style :bold}
                                          :operator {:style :bold}
                                          :parameter {:style :italic}
                                          :variable {:style :italic}
                                          :variableBuiltIn {:style "italic,bold"}}
                                 :transparent false}))

M


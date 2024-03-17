(local config {})

(fn config.setup []
  ((. (require :lspkind) :init) {:mode :symbol_text
                                 :preset :default
                                 :symbol_map {:Class ""
                                              :Color ""
                                              :Constant ""
                                              :Constructor ""
                                              :Enum "了"
                                              :EnumMember ""
                                              :File ""
                                              :Folder ""
                                              :Function ""
                                              :Interface "ﰮ"
                                              :Keyword ""
                                              :Method "ƒ"
                                              :Module ""
                                              :Property ""
                                              :Snippet "﬌"
                                              :Struct ""
                                              :Text ""
                                              :Unit ""
                                              :Value ""
                                              :Variable ""}}))

config


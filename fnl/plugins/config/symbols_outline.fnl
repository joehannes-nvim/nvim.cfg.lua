(local M {})

(fn M.setup []
  (let [opts {:auto_close false
              :auto_preview true
              :auto_unfold_hover true
              :autofold_depth 2
              :fold_markers ["" ""]
              :highlight_hovered_item true
              :keymaps {:close [:<Esc> :q]
                        :code_actions :a
                        :focus_location :o
                        :fold :c
                        :fold_all :C
                        :fold_reset :R
                        :goto_location :<Cr>
                        :hover_symbol :<C-space>
                        :rename_symbol :r
                        :toggle_preview :K
                        :unfold :o
                        :unfold_all :O}
              :lsp_blacklist {}
              :position :right
              :preview_bg_highlight :Pmenu
              :relative_width true
              :show_guides true
              :show_numbers false
              :show_relative_numbers false
              :show_symbol_details false
              :symbol_blacklist {}
              :symbols {:Array {:hl :TSConstant :icon ""}
                        :Boolean {:hl :TSBoolean :icon "⊨"}
                        :Class {:hl :TSType :icon "𝓒"}
                        :Constant {:hl :TSConstant :icon ""}
                        :Constructor {:hl :TSConstructor :icon ""}
                        :Enum {:hl :TSType :icon "ℰ"}
                        :EnumMember {:hl :TSField :icon ""}
                        :Event {:hl :TSType :icon "🗲"}
                        :Field {:hl :TSField :icon ""}
                        :File {:hl :TSURI :icon ""}
                        :Function {:hl :TSFunction :icon ""}
                        :Interface {:hl :TSType :icon "ﰮ"}
                        :Key {:hl :TSType :icon "🔐"}
                        :Method {:hl :TSMethod :icon "ƒ"}
                        :Module {:hl :TSNamespace :icon ""}
                        :Namespace {:hl :TSNamespace :icon ""}
                        :Null {:hl :TSType :icon :NULL}
                        :Number {:hl :TSNumber :icon "#"}
                        :Object {:hl :TSType :icon "⦿"}
                        :Operator {:hl :TSOperator :icon "+"}
                        :Package {:hl :TSNamespace :icon ""}
                        :Property {:hl :TSMethod :icon ""}
                        :String {:hl :TSString :icon "𝓐"}
                        :Struct {:hl :TSType :icon "𝓢"}
                        :TypeParameter {:hl :TSParameter :icon "𝙏"}
                        :Variable {:hl :TSConstant :icon ""}}
              :width 15}]
    ((. (require :symbols-outline) :setup) opts)))

M


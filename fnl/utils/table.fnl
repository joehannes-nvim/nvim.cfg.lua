(local M {})

(fn M.table_has_val [tab val]
  (each [_ value (ipairs tab)] (when (= value val) (lua "return true")))
  false)

(fn M.table_has_key [tab idx]
  (each [index _ (pairs tab)] (when (= index idx) (lua "return true")))
  false)

(fn M.table_merge [...]
  (let [args [...]
        merged {}]
    (when (< (length args) 2)
      (when (= (length args) 1)
        (let [___antifnl_rtn_1___ (. args 1)]
          (lua "return ___antifnl_rtn_1___")))
      (let [___antifnl_rtn_1___ {}] (lua "return ___antifnl_rtn_1___")))
    (each [k v (ipairs args)]
      (if (= (type v) :table) (each [k2 v2 (pairs v)] (tset merged k2 v2))
          (vim.notify (.. "table_merge: expected table, got " (type v)
                          " at index " k))))
    merged))

M


(local my _G.my)
(local (api vfn cmd g ft) (values vim.api vim.fn vim.cmd vim.g vim.bo.filetype))

(local M {})

(fn get-dir-contains [path dirname]
  (fn pathname [path]
    (var prefix "")
    (local i (path:find "[\\/:][^\\/:]*$"))
    (when i
      (set prefix (path:sub 1 (- i 1))))
    prefix)

  (fn up-one-level [path]
    (when (= path nil) (set-forcibly! path "."))
    (when (= path ".")
      (set-forcibly! path (: (io.popen :cd) :read :*l)))
    (pathname path))

  (fn has-specified-dir [path specified-dir]
    (when (= path nil) (set-forcibly! path "."))
    (my.fs.isdir (.. path "/" specified-dir)))

  (when (= path nil) (set-forcibly! path "."))
  (if (has-specified-dir path dirname) (.. path "/" dirname)
      (let [parent-path (up-one-level path)]
        (if (= parent-path path) nil (get-dir-contains parent-path dirname)))))

(fn _G.get-root-dir [path]
  (fn pathname [path]
    (var prefix "")
    (local i (path:find "[\\/:][^\\/:]*$"))
    (when i
      (set prefix (path:sub 1 (- i 1))))
    prefix)

  (fn has-git-dir [dir]
    (let [git-dir (.. dir :/.git)] (when (my.fs.isdir git-dir) git-dir)))

  (fn has-git-file [dir]
    (let [gitfile (io.open (.. dir :/.git))]
      (when (not gitfile) (lua "return false"))
      (local git-dir (: (gitfile:read) :match "gitdir: (.*)"))
      (gitfile:close)
      (and git-dir (.. dir "/" git-dir))))

  (when (or (not path) (= path "."))
    (set-forcibly! path (: (io.popen :cd) :read :*l)))
  (local parent-path (pathname path))
  (or (or (has-git-dir path) (has-git-file path))
      (or (and (not= parent-path path) (M.get_root_dir parent-path)) nil)))

(fn _G.check-workspace []
  (let [current-file (vfn.expand "%:p")]
    (when (or (= current-file "") (= current-file nil)) (lua "return false"))
    (var current-dir nil)
    (if (= (vfn.getftype current-file) :link)
        (let [real-file (vfn.resolve current-file)]
          (set current-dir (vfn.fnamemodify real-file ":h")))
        (set current-dir (vfn.expand "%:p:h")))
    (local result (M.get_root_dir current-dir))
    (when (not result) (lua "return false"))
    true))

(fn _G.get-branch []
  (when (= ft :help) (lua "return "))
  (local current-file (vfn.expand "%:p"))
  (var current-dir nil)
  (if (= (vfn.getftype current-file) :link)
      (let [real-file (vfn.resolve current-file)]
        (set current-dir (vfn.fnamemodify real-file ":h")))
      (set current-dir (vfn.expand "%:p:h")))
  (local (ok-gpwd gitbranch-pwd) (pcall api.nvim_buf_get_var 0 :gitbranch_pwd))
  (local (ok-gpath gitbranch-path)
         (pcall api.nvim_buf_get_var 0 :gitbranch_path))
  (when (and ok-gpwd ok-gpath)
    (when (and (gitbranch-path:find current-dir)
               (not= (string.len gitbranch-pwd) 0))
      (let [___antifnl_rtn_1___ gitbranch-pwd]
        (lua "return ___antifnl_rtn_1___"))))
  (local git-dir (M.get_root_dir current-dir))
  (when (not git-dir) (lua "return \"\""))
  (var git-root nil)
  (when (not (git-dir:find :/.git)) (set git-root git-dir))
  (set git-root (git-dir:gsub :/.git ""))
  (local head-file (and git-dir (io.open (.. git-dir :/HEAD))))
  (when (not head-file) (lua "return \"\""))
  (local HEAD (head-file:read))
  (head-file:close)
  (local branch-name (HEAD:match "ref: refs/heads/(.+)"))
  (when (= branch-name nil) (lua "return \"\""))
  (api.nvim_buf_set_var 0 :gitbranch_pwd branch-name)
  (api.nvim_buf_set_var 0 :gitbranch_path git-root)
  (or branch-name ""))

M


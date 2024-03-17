; ### Git LUA API
;
; This module can be loaded with `local git = require "astronvim.utils.git"`
;
; @module astronvim.utils.git
; @copyright 2022
; @license GNU General Public License v3.0

(local git {:url "https://github.com/"})
(fn trim-or-nil [str]
  (or (and (= (type str) :string) (vim.trim str)) nil))
(fn git.cmd [args ...]
  (when (= (type args) :string) (set-forcibly! args [args]))
  ((. (require :utils.astro) :cmd) (vim.list_extend [:git
                                                   :-C
                                                   _G.my.astro.install.home]
                                                  args)
                                 ...))
(fn git.file_worktree [file worktrees]
  (set-forcibly! worktrees (or worktrees vim.g.git_worktrees))
  (when (not worktrees) (lua "return "))
  (set-forcibly! file (or file (vim.fn.expand "%")))
  (each [_ worktree (ipairs worktrees)]
    (when ((. (require :utils.astro) :cmd) [:git
                                          :--work-tree
                                          worktree.toplevel
                                          :--git-dir
                                          worktree.gitdir
                                          :ls-files
                                          :--error-unmatch
                                          file
                                               false])
      (lua "return worktree"))))
(fn git.available [] (= (vim.fn.executable :git) 1))
(fn git.git_version []
  (let [output (git.cmd [:--version] false)]
    (when output
      (local version-str (output:match "%d+%.%d+%.%d"))
      (local (major min patch)
             (unpack (vim.tbl_map tonumber (vim.split version-str "%."))))
      {: major : min : patch :str version-str})))
(fn git.is_repo [] (git.cmd [:rev-parse :--is-inside-work-tree] false))
(fn git.fetch [remote ...] (git.cmd [:fetch remote] ...))
(fn git.pull [...] (git.cmd [:pull :--rebase] ...))
(fn git.checkout [dest ...] (git.cmd [:checkout dest] ...))
(fn git.hard_reset [dest ...] (git.cmd [:reset :--hard dest] ...))
(fn git.branch_contains [remote branch commit ...]
  (not= (git.cmd [:merge-base :--is-ancestor commit (.. remote "/" branch)] ...)
        nil))
(fn git.branch_remote [branch ...]
  (trim-or-nil (git.cmd [:config (.. :branch. branch :.remote)] ...)))
(fn git.remote_add [remote url ...] (git.cmd [:remote :add remote url] ...))
(fn git.remote_update [remote url ...]
  (git.cmd [:remote :set-url remote url] ...))
(fn git.remote_url [remote ...]
  (trim-or-nil (git.cmd [:remote :get-url remote] ...)))
(fn git.remote_set_branches [remote branch ...]
  (git.cmd [:remote :set-branches remote branch] ...))
(fn git.current_version [...]
  (trim-or-nil (git.cmd [:describe :--tags] ...)))
(fn git.current_branch [...]
  (trim-or-nil (git.cmd [:rev-parse :--abbrev-ref :HEAD] ...)))
(fn git.ref_verify [ref ...]
  (trim-or-nil (git.cmd [:rev-parse :--verify ref] ...)))
(fn git.local_head [...]
  (trim-or-nil (git.cmd [:rev-parse :HEAD] ...)))
(fn git.remote_head [remote branch ...]
  (trim-or-nil (git.cmd [:rev-list :-n :1 (.. remote "/" branch)] ...)))
(fn git.tag_commit [tag ...]
  (trim-or-nil (git.cmd [:rev-list :-n :1 tag] ...)))
(fn git.get_commit_range [start-hash end-hash ...]
  (let [range (or (and (and start-hash end-hash) (.. start-hash ".." end-hash))
                  nil)
        log (git.cmd [:log :--no-merges "--pretty=\"format:[%h] %s\"" range]
                     ...)]
    (or (and log (vim.fn.split log "\n")) {})))
(fn git.get_versions [search ...]
  (let [tags (git.cmd [:tag
                       :-l
                       "--sort=version:refname"
                       (or (and (= search :latest) :v*) search)]
                      ...)]
    (or (and tags (vim.fn.split tags "\n")) {})))
(fn git.latest_version [versions ...]
  (when (not versions) (set-forcibly! versions (git.get_versions ...)))
  (. versions (length versions)))
(fn git.parse_remote_url [str]
  (or (and (= (vim.fn.match str (. (require :utils.astro) :url_matcher))
              (- 1)) (.. git.url str
                                    (or (= (vim.fn.match str "/") (- 1))
                                        :.git))) str))
(fn git.is_breaking [commit]
  (not= (vim.fn.match commit "\\[.*\\]\\s\\+\\w\\+\\((\\w\\+)\\)\\?!:") (- 1)))
(fn git.breaking_changes [commits] (vim.tbl_filter git.is_breaking commits))
(fn git.pretty_changelog [commits]
  (let [changelog {}]
    (each [_ commit (ipairs commits)]
      (local (hash type msg) (commit:match "(%[.*%])(.*:)(.*)"))
      (when (and (and hash type) msg)
        (vim.list_extend changelog [[hash :DiffText]
                                    [type
                                     (or (and (git.is_breaking commit)
                                              :DiffDelete)
                                         :DiffChange)]
                                    [msg]
                                    ["\n"]])))
    changelog))
git

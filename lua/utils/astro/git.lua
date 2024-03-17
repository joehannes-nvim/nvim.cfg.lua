-- [nfnl] Compiled from fnl/utils/astro/git.fnl by https://github.com/Olical/nfnl, do not edit.
local git = {url = "https://github.com/"}
local function trim_or_nil(str)
  return (((type(str) == "string") and vim.trim(str)) or nil)
end
git.cmd = function(args, ...)
  if (type(args) == "string") then
    args = {args}
  else
  end
  return (require("utils.astro")).cmd(vim.list_extend({"git", "-C", _G.my.astro.install.home}, args), ...)
end
git.file_worktree = function(file, worktrees)
  worktrees = (worktrees or vim.g.git_worktrees)
  if not worktrees then
    return 
  else
  end
  file = (file or vim.fn.expand("%"))
  for _, worktree in ipairs(worktrees) do
    if (require("utils.astro")).cmd({"git", "--work-tree", worktree.toplevel, "--git-dir", worktree.gitdir, "ls-files", "--error-unmatch", file, false}) then
      return worktree
    else
    end
  end
  return nil
end
git.available = function()
  return (vim.fn.executable("git") == 1)
end
git.git_version = function()
  local output = git.cmd({"--version"}, false)
  if output then
    local version_str = output:match("%d+%.%d+%.%d")
    local major, min, patch = unpack(vim.tbl_map(tonumber, vim.split(version_str, "%.")))
    return {major = major, min = min, patch = patch, str = version_str}
  else
    return nil
  end
end
git.is_repo = function()
  return git.cmd({"rev-parse", "--is-inside-work-tree"}, false)
end
git.fetch = function(remote, ...)
  return git.cmd({"fetch", remote}, ...)
end
git.pull = function(...)
  return git.cmd({"pull", "--rebase"}, ...)
end
git.checkout = function(dest, ...)
  return git.cmd({"checkout", dest}, ...)
end
git.hard_reset = function(dest, ...)
  return git.cmd({"reset", "--hard", dest}, ...)
end
git.branch_contains = function(remote, branch, commit, ...)
  return (git.cmd({"merge-base", "--is-ancestor", commit, (remote .. "/" .. branch)}, ...) ~= nil)
end
git.branch_remote = function(branch, ...)
  return trim_or_nil(git.cmd({"config", ("branch." .. branch .. ".remote")}, ...))
end
git.remote_add = function(remote, url, ...)
  return git.cmd({"remote", "add", remote, url}, ...)
end
git.remote_update = function(remote, url, ...)
  return git.cmd({"remote", "set-url", remote, url}, ...)
end
git.remote_url = function(remote, ...)
  return trim_or_nil(git.cmd({"remote", "get-url", remote}, ...))
end
git.remote_set_branches = function(remote, branch, ...)
  return git.cmd({"remote", "set-branches", remote, branch}, ...)
end
git.current_version = function(...)
  return trim_or_nil(git.cmd({"describe", "--tags"}, ...))
end
git.current_branch = function(...)
  return trim_or_nil(git.cmd({"rev-parse", "--abbrev-ref", "HEAD"}, ...))
end
git.ref_verify = function(ref, ...)
  return trim_or_nil(git.cmd({"rev-parse", "--verify", ref}, ...))
end
git.local_head = function(...)
  return trim_or_nil(git.cmd({"rev-parse", "HEAD"}, ...))
end
git.remote_head = function(remote, branch, ...)
  return trim_or_nil(git.cmd({"rev-list", "-n", "1", (remote .. "/" .. branch)}, ...))
end
git.tag_commit = function(tag, ...)
  return trim_or_nil(git.cmd({"rev-list", "-n", "1", tag}, ...))
end
git.get_commit_range = function(start_hash, end_hash, ...)
  local range = (((start_hash and end_hash) and (start_hash .. ".." .. end_hash)) or nil)
  local log = git.cmd({"log", "--no-merges", "--pretty=\"format:[%h] %s\"", range}, ...)
  return ((log and vim.fn.split(log, "\n")) or {})
end
git.get_versions = function(search, ...)
  local tags = git.cmd({"tag", "-l", "--sort=version:refname", (((search == "latest") and "v*") or search)}, ...)
  return ((tags and vim.fn.split(tags, "\n")) or {})
end
git.latest_version = function(versions, ...)
  if not versions then
    versions = git.get_versions(...)
  else
  end
  return versions[#versions]
end
git.parse_remote_url = function(str)
  return (((vim.fn.match(str, (require("utils.astro")).url_matcher) == ( - 1)) and (git.url .. str .. ((vim.fn.match(str, "/") == ( - 1)) or ".git"))) or str)
end
git.is_breaking = function(commit)
  return (vim.fn.match(commit, "\\[.*\\]\\s\\+\\w\\+\\((\\w\\+)\\)\\?!:") ~= ( - 1))
end
git.breaking_changes = function(commits)
  return vim.tbl_filter(git.is_breaking, commits)
end
git.pretty_changelog = function(commits)
  local changelog = {}
  for _, commit in ipairs(commits) do
    local hash, type, msg = commit:match("(%[.*%])(.*:)(.*)")
    if ((hash and type) and msg) then
      vim.list_extend(changelog, {{hash, "DiffText"}, {type, ((git.is_breaking(commit) and "DiffDelete") or "DiffChange")}, {msg}, {"\n"}})
    else
    end
  end
  return changelog
end
return git

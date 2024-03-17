-- [nfnl] Compiled from fnl/plugins/git.fnl by https://github.com/Olical/nfnl, do not edit.
local function _1_()
  return (require("plugins.config.gitsigns")).setup()
end
local function _2_()
  return (require("plugins.config.diffview")).setup()
end
local function _3_()
  return (require("neogit")).setup({integrations = {diffview = true}})
end
local function _4_()
  do end (require("git-conflict")).setup({default_mappings = true, disable_diagnostics = true, highlights = {current = "DiffAdd", incoming = "DiffText"}})
  local function _5_()
    return vim.notify(("Conflict detected in " .. vim.fn.expand("<afile>")))
  end
  return vim.api.nvim_create_autocmd("User", {callback = _5_, pattern = "GitConflictDetected"})
end
local function _6_()
  return (require("gitlinker")).setup({callbacks = {["bitbucket.org"] = (require("gitlinker.hosts")).get_bitbucket_type_url, ["codeberg.org"] = (require("gitlinker.hosts")).get_gitea_type_url, ["git.kernel.org"] = (require("gitlinker.hosts")).get_cgit_type_url, ["git.launchpad.net"] = (require("gitlinker.hosts")).get_launchpad_type_url, ["git.savannah.gnu.org"] = (require("gitlinker.hosts")).get_cgit_type_url, ["git.sr.ht"] = (require("gitlinker.hosts")).get_srht_type_url, ["github.com"] = (require("gitlinker.hosts")).get_github_type_url, ["gitlab.com"] = (require("gitlinker.hosts")).get_gitlab_type_url, ["repo.or.cz"] = (require("gitlinker.hosts")).get_repoorcz_type_url, ["try.gitea.io"] = (require("gitlinker.hosts")).get_gitea_type_url, ["try.gogs.io"] = (require("gitlinker.hosts")).get_gogs_type_url}, opts = {action_callback = (require("gitlinker.actions")).copy_to_clipboard, add_current_line_on_normal_mode = true, print_url = true, remote = nil}})
end
return {{"lewis6991/gitsigns.nvim", config = _1_, dependencies = {"nvim-lua/plenary.nvim"}}, {"tpope/vim-fugitive"}, {"sindrets/diffview.nvim", config = _2_}, {"NeogitOrg/neogit", config = _3_, dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim"}}, {"akinsho/git-conflict.nvim", config = _4_}, {"ruifm/gitlinker.nvim", config = _6_, dependencies = "nvim-lua/plenary.nvim"}}

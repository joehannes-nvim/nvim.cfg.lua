-- [nfnl] Compiled from fnl/plugins/config/telescope.fnl by https://github.com/Olical/nfnl, do not edit.
local config = {}
config.setup = function()
  local trouble = require("trouble.providers.telescope")
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local function _1_(filepath, bufnr, opts)
    local function is_image(filepath0)
      local image_extensions = {"png", "jpg", "jpeg", "gif"}
      local split_path = vim.split(filepath0:lower(), ".", {plain = true})
      local extension = split_path[#split_path]
      return vim.tbl_contains(image_extensions, extension)
    end
    if is_image(filepath) then
      local term = vim.api.nvim_open_term(bufnr, {})
      local function send_output(_, data, _0)
        for _1, d in ipairs(data) do
          vim.api.nvim_chan_send(term, (d .. "\13\n"))
        end
        return nil
      end
      return vim.fn.jobstart({"viu", filepath}, {on_stdout = send_output, stdout_buffered = true})
    else
      return (require("telescope.previewers.utils")).set_preview_message(bufnr, opts.winid, "Binary cannot be previewed")
    end
  end
  local function _3_(prompt_bufnr)
    return (require("telescope._extensions.project.actions")).change_working_directory(prompt_bufnr, false)
  end
  local function _4_(prompt_bufnr)
    actions.close(prompt_bufnr)
    local value = actions.get_selected_entry(prompt_bufnr).value
    return vim.cmd(("DiffviewOpen " .. value .. "~1.." .. value))
  end
  telescope.setup({defaults = {history = {limit = 100, path = (vim.fn.stdpath("data") .. "/databases/telescope_history.sqlite3")}, initial_mode = "insert", mappings = {i = {["<c-l>"] = trouble.open_with_trouble, ["<c-q>"] = actions.smart_send_to_qflist}, n = {["<c-l>"] = trouble.open_with_trouble, ["<c-q>"] = actions.smart_send_to_qflist}}, path_display = {truncate = 1}, preview = {mime_hook = _1_}}, extensions = {arecibo = {selected_engine = "google", url_open_command = "open", show_http_headers = false, show_domain_icons = false}, dash = {dash_app_path = "/Applications/Dash.app", debounce = 300, file_type_keywords = {TelescopePrompt = true, clojure = {"clojure", "clj", "javascript", "html", "svg", "css"}, javascript = {"javascript", "html", "svg", "nodejs", "css", "sass", "react"}, javascriptreact = {"javascript", "html", "svg", "nodejs", "css", "sass", "react"}, lua = {"lua", "Neovim"}, packer = true, terminal = true, typescript = {"typescript", "javascript", "nodejs", "html", "svg", "nodejs", "css", "sass"}, typescriptreact = {"typescript", "javascript", "html", "svg", "nodejs", "css", "sass", "react"}, NvimTree = false, dashboard = false, fzf = false}, search_engine = "google"}, frecency = {db_root = (vim.fn.stdpath("data") .. "/databases"), ignore_patterns = {"*.git/*", "*/tmp/*"}, show_unindexed = true, workspaces = {conf = (vim.fn.expand("$HOME") .. "/.config"), data = (vim.fn.expand("$HOME") .. "/.local/share"), orb = (vim.fn.expand("$HOME") .. "/.local/git/orbital"), project = (vim.fn.expand("$HOME") .. "./.local/git"), wiki = (vim.fn.expand("$HOME") .. "/wiki")}, show_scores = false, disable_devicons = false}, fzf = {case_mode = "smart_case", fuzzy = true, override_file_sorter = true, override_generic_sorter = true}, media_files = {filetypes = {"png", "webp", "jpg", "jpeg", "mp4", "webm", "pdf"}, find_cmd = "rg"}, persisted = {layout_config = {height = 0.7, width = 0.7}}, project = {base_dirs = {{path = "~/.config/nvim"}, {max_depth = 3, path = "~/.local/git"}}, hidden_files = true, on_project_selected = _3_}, ["ui-select"] = {(require("telescope.themes")).get_dropdown({})}, undo = {layout_config = {preview_height = 0.8}, layout_strategy = "vertical", side_by_side = true}}, file_previewer = (require("telescope.previewers")).vim_buffer_cat.new, grep_previewer = (require("telescope.previewers")).vim_buffer_vimgrep.new, pickers = {buffers = {theme = "dropdown"}, find_files = {hidden = true, theme = "dropdown"}, git_branches = {theme = "dropdown"}, git_commits = {mappings = {i = {["<CR>"] = _4_}}}, lsp_code_actions = {theme = "cursor"}, lsp_range_code_actions = {theme = "cursor"}, oldfiles = {theme = "dropdown"}, spell_suggest = {theme = "cursor"}, colorscheme = {enable_preview = true}}, qflist_previewer = (require("telescope.previewers")).vim_buffer_qflist.new, use_less = true})
  telescope.load_extension("fzf")
  telescope.load_extension("gh")
  telescope.load_extension("node_modules")
  telescope.load_extension("project")
  telescope.load_extension("neoclip")
  telescope.load_extension("smart_history")
  telescope.load_extension("arecibo")
  telescope.load_extension("media_files")
  telescope.load_extension("frecency")
  telescope.load_extension("ui-select")
  telescope.load_extension("undo")
  telescope.load_extension("ag")
  telescope.load_extension("persisted")
  return telescope.load_extension("scope")
end
return config

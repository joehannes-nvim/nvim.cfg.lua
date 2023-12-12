return {
  { "editorconfig/editorconfig-vim" },
  { "wakatime/vim-wakatime" },
  { "chrisbra/unicode.vim" },
  { "kkharji/sqlite.lua" },
  {
    'junegunn/fzf',
    build = function()
      vim.fn['fzf#install']()
    end
  },
  {
    "roobert/hoversplit.nvim",
    config = function()
      require("hoversplit").setup({
        -- key_bindings = {
        --   split_remain_focused = "<leader>hs",
        --   vsplit_remain_focused = "<leader>hv",
        --   split = "<leader>hS",
        --   vsplit = "<leader>hV",
        -- },
      })
    end,
  },
  -- {
  --   "amrbashir/nvim-docs-view",
  --   config = function()
  --     require("docs-view").setup {
  --       position = "bottom",
  --       height = 17,
  --     }
  --   end
  -- },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "kkharji/sqlite.lua",
      "nvim-telescope/telescope-project.nvim",
      "nvim-telescope/telescope-smart-history.nvim",
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-telescope/telescope-symbols.nvim",
      "nvim-telescope/telescope-node-modules.nvim",
      "nvim-telescope/telescope-github.nvim",
      "nvim-telescope/telescope-arecibo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      -- "nvim-telescope/telescope-dap.nvim",
      -- "nvim-telescope/telescope-media-files.nvim",
      "joehannes-os/telescope-media-files.nvim",
      -- "nvim-telescope/telescope-snippets.nvim",
      -- "tom-anders/telescope-vim-bookmarks.nvim",
      "debugloop/telescope-undo.nvim",
      "sudormrfbin/cheatsheet.nvim",
      "AckslD/nvim-neoclip.lua",
      -- "rmagatti/auto-session",
      -- "rmagatti/session-lens",
      "Azeirah/nvim-redux",
      "tiagovla/scope.nvim",
    },
    config = function()
      local config = require("plugins/config/telescope")
      local neoclip = require("plugins/config/neoclip")

      config.setup()
      neoclip.setup()
    end,
  },
  {
    "kelly-lin/telescope-ag",
    dependencies = "nvim-telescope/telescope.nvim",
    config = function()
      require("telescope-ag").setup({})
    end
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("plugins.config.scrollbar").setup()
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    config = function() require("plugins.config.bqf").setup() end,
    dependencies = { "fzf", "nvim-treesitter", "vim-grepper" }
  },
  { "RRethy/vim-illuminate" },
  {
    "abecodes/tabout.nvim",
    config = function()
      require("tabout").setup({
        tabkey = ">>",            -- key to trigger tabout, set to an empty string to disable
        backwards_tabkey = "<<",  -- key to trigger backwards tabout, set to an empty string to disable
        act_as_tab = false,       -- shift content if tab out is not possible
        act_as_shift_tab = false, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        enable_backwards = true,  -- well ...
        completion = false,       -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "'", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
          { open = "<", close = ">" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    dependencies = { "nvim-cmp", "nvim-treesitter" }, -- or require if not used so far
  },
  { "smitajit/bufutils.vim" },
  { "arithran/vim-delete-hidden-buffers" },
  {
    "kazhala/close-buffers.nvim",
    dependencies = { "akinsho/bufferline.nvim" },
    config = function()
      require("close_buffers").setup({
        filetype_ignore = { "qf" },
        file_glob_ignore = { "src/**/*" },
        preserve_window_layout = { "this", "nameless" },
        next_buffer_cmd = function(windows)
          require("bufferline").cycle(1)
          local bufnr = vim.api.nvim_get_current_buf()

          for _, window in ipairs(windows) do
            vim.api.nvim_win_set_buf(window, bufnr)
          end
        end,
      })
    end,
  },
  {
    "Krafi2/jeskape.nvim",
    config = function()
      require("jeskape").setup({
        -- Mappings are specified in this table. Jeskape uses neovim's keymap
        -- system under the hood, so anything allowed in a normal `map`'s righ hand
        -- side will work here too. Check out ':h  map.txt' to see what's possible.
        mappings = {
          -- Typing `hi` quickly will cause the string `hello!` to be inserted.
          -- hi = "hello!",
          -- They can also be specified in a tree-like format.
          j = {
            -- Here `jk` will escape insert mode.
            k = "<cmd>stopinsert<cr><cmd>w!<cr>",
            -- You can have as many layers as you want!
            -- h = {
            -- 	g = "<cmd>stopinsert<cr>",
            -- },
            -- If the mapping leads to a function, it will be evaluated every
            -- time the mapping is reached and its return value will be fed to
            -- neovim.
            -- f = function()
            -- 	print("Oh look, a function!")
            -- 	-- Insert the name of the current file.
            -- 	return vim.fn.expand("%:t")
            -- end,
          },
          -- You can use lua's arbitrary key notation to map special characters
          -- move to end of WORD and enter insert mode after that char
          -- [";;"] = "<cmd>stopinsert<cr><cmd>w<cr><cmd>normal W<cr><cmd>startinsert<cr>",
          -- [";l"] = "<cmd>stopinsert<cr><cmd>normal f)a<cr>",
          -- [";h"] = "<cmd>stopinsert<cr><cmd>normal F(a<cr>",
          ["<Esc>"] = "<cmd>stopinsert<cr>",
          ["<leader>"] = {
            ["<leader>"] = "<cmd>w<cr>",
          }
          -- Use `<cmd>` to map commands. Be carful to terminate the command with `<cr>`.
          -- ff = "<cmd>echo 'commands work too'<cr>",
        },
        -- The maximum length of time between keystrokes where they are still
        -- considered a part of the same mapping.
        timeout = vim.o.timeoutlen,
      })
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    cmd = "PasteImage",
    opts = {
      -- add options here
      -- or leave it empty to use the default settings
    },
    keys = {
      -- suggested keymap
      { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
    },
    config = function()
      require('plugins.config.pasteimg').setup()
    end
  },
  {
    "folke/which-key.nvim",
    config = function() require("which-key").setup() end,
  }
}

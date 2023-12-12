return {
  {
    "Olical/nfnl",
    ft = "fennel"
  },
  {
    "folke/neodev.nvim",
    opts = {},
    config = function()
      require("neodev").setup({})
    end
  },
  { "nvim-lua/plenary.nvim" },
  { "stevearc/dressing.nvim" },
  { "MunifTanjim/nui.nvim" },
  {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function() require("plugins.config.notify").setup() end,
  },
  { "nvim-lua/popup.nvim" },
  -- {
  --   "folke/noice.nvim",
  --   cond = function() return not vim.g.neovide end,
  --   config = function()
  --     require("plugins.config.noice").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "rcarriga/nvim-notify",
  --   }
  -- },
  -- {
  --   "ellisonleao/glow.nvim",
  --   -- config = function() require("plugins.config.glow").setup() end,
  -- },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      require("plugins.config.statuscol").setup()
    end,
  },
  { "nathom/filetype.nvim" },
  {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup({
        save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"), -- directory where session files are saved
        silent = true,                                                    -- silent nvim message when sourcing session file
        use_git_branch = true,                                            -- create session files based on the branch of the git enabled repository
        autosave = true,                                                  -- automatically save session files when exiting Neovim
        should_autosave = nil,                                            -- function to determine if a session should be autosaved
        autoload = false,                                                 -- automatically load the session for the cwd on Neovim startup
        on_autoload_no_session = function()
          -- require("plugins.config.heirline").setup(false)
          -- require("heirline").setup({
          --   heirline = require("plugins.config.heirline").StatusLine,
          --   winbar = require("plugins.config.heirline").WinBars,
          -- })
        end,                                  -- function to run when `autoload = true` but there is no session to load
        follow_cwd = true,                    -- change session file name to match current working directory if it changes
        allowed_dirs = nil,                   -- table of dirs that the plugin will auto-save and auto-load from
        ignored_dirs = nil,                   -- table of dirs that are ignored when auto-saving and auto-loading
        telescope = {                         -- options for the telescope extension
          reset_prompt_after_deletion = true, -- whether to reset prompt after session deleted
        }
      })
    end
  },
  -- {
  --   "rmagatti/auto-session",
  --   config = function() require("plugins.config.auto_session").setup() end,
  -- },
  -- {
  --   "rmagatti/session-lens",
  --   dependencies = { "rmagatti/auto-session", "nvim-telescope/telescope.nvim" },
  --   config = function()
  --     require("session-lens").setup({
  --       path_display = { "shorten" },
  --       theme_conf = { border = false },
  --       previewer = false,
  --     })
  --     require("telescope").load_extension("session-lens")
  --   end
  -- },
  { "tversteeg/registers.nvim" },
  { "kevinhwang91/promise-async" },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    config = function()
      require("plugins.config.ufo").setup()
    end
  },
  {
    "gelguy/wilder.nvim",
    config = function() require("plugins.config.wilder").setup() end,
  },
  { "indianboy42/hop-extensions" },
  {
    "karb94/neoscroll.nvim",
    config = function() require("plugins.config.scroll").setup() end,
  },
  -- { "unblevable/quick-scope" },
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 17
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        -- open_mapping = [[<leader>;]],
        -- on_create = function(t) end, -- function to run when the terminal is first created
        on_open = function(t)
          my.ui.addTerminal(t)
          vim.cmd('startinsert!')
        end, -- function to run when the terminal opens
        -- on_close = function(t) my.ui.removeTerminal(t) end, -- function to run when the terminal closes
        -- on_stdout = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stdout
        -- on_stderr = fun(t: Terminal, job: number, data: string[], name: string) -- callback for processing output on stderr
        on_exit = function(t) my.ui.removeTerminal(t) end,
        -- fun(t: Terminal, job: number, exit_code: number, name: string) -- function to run when terminal process exits
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        autochdir = true,    -- when neovim changes it current directory the terminal will change it's own when next it's opened
        highlights = {
          -- highlights which map to a highlight group name and a table of it's values
          -- NOTE: this is only a subset of values, any group placed here will be set for the terminal window split
          Normal = {
            guibg = my.color.hsl(my.color.my[vim.opt.background:get()]).mix(my.color.hsl(my.color.my.vimode[
            vim.fn.mode()
            or "n"]), 21),
          },
          NormalFloat = {
            link = 'Normal'
          },
          FloatBorder = {
            guifg = my.color.my.magenta,
            guibg = "NONE",
          },
        },
        shade_terminals = true,   -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
        shading_factor = -21,     -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
        start_in_insert = true,
        insert_mappings = true,   -- whether or not the open mapping applies in insert mode
        terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
        persist_size = true,
        persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
        direction = 'horizontal', -- | 'horizontal' | 'tab' | 'float',
        close_on_exit = true,     -- close the terminal window when the process exits
        shell = vim.o.shell,      -- change the default shell
        auto_scroll = true,       -- automatically scroll to the bottom on terminal output
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
          -- The border key is *almost* the same as 'nvim_open_win'
          -- see :h nvim_open_win for details on borders however
          -- the 'curved' border is a custom border type
          -- not natively supported but implemented in this plugin.
          border = 'curved', --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
          -- like `size`, width and height can be a number or function which is passed the current terminal
          width = vim.g.neovide and 200 or math.ceil(vim.o.columns * 0.9),
          height = vim.g.neovide and vim.o.lines - 3 or math.ceil(vim.o.lines * 0.9),
          winblend = 30,
        },
        winbar = {
          enabled = true,
          name_formatter = function(term) --  term: Terminal
            return term.name
          end
        },
      })
    end
  },
  -- {
  --   'rebelot/terminal.nvim',
  --   config = function() require("terminal").setup({
  --       layout = { open_cmd = "botright new", width = 1, height = 0.37 },
  --       cmd = { vim.o.shell },
  --       autoclose = false,
  --     })
  --   end,
  -- },
  -- { "lokaltog/neoranger" },
  {
    "kelly-lin/ranger.nvim",
    config = function()
      require("ranger-nvim").setup({ replace_netrw = true })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },
  {
    'kosayoda/nvim-lightbulb',
    dependencies = { 'antoinemadec/FixCursorHold.nvim' },
    config = function() require("plugins.config.lightbulb").setup() end,
  },
  {
    'mrshmllow/document-color.nvim',
    config = function()
      require("document-color").setup {
        -- Default options
        mode = "background", -- "background" | "foreground" | "single"
      }
    end
  },
  { "mhinz/vim-grepper" },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({
        detection_methods = { "pattern" },
      })
    end,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup({
        enabled = true,
        input_after_comment = true,
        languages = {
          javascript = {
            template = {
              annotation_convention = "jsdoc",
            }
          },
          javascriptreact = {
            template = {
              annotation_convention = "jsdoc",
            }
          },
          typescript = {
            template = {
              annotation_convention = "tsdoc",
            }
          },
          typescriptreact = {
            template = {
              annotation_convention = "tsdoc",
            }
          }
        }
      })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- stable versions only
    -- tag = "*"
  }
}

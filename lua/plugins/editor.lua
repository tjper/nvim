return {
  { "RRethy/vim-illuminate" },
  { "norcalli/nvim-colorizer.lua" },
  { "folke/todo-comments.nvim" },
  { 
    "sphamba/smear-cursor.nvim",
    opts = {
      stiffness = 0.8,
      trailing_stiffness = 0.6,
      stiffness_insert_mode = 0.7,
      trailing_stiffness_insert_mode = 0.7,
      damping = 0.95,
      damping_insert_mode = 0.95,
      distance_stop_animating = 0.5,
    }
  },
  {
    "karb94/neoscroll.nvim",
    config = function() 
      require("neoscroll").setup({
        easing = "sine"
      })
    end
  },
  { 
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, _)
      require("lualine").setup()
    end
  },
  {
    "oskarnurm/koda.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- require("koda").setup({ transparent = true })
      vim.cmd("colorscheme koda")
    end,
  },
  {
    'sainnhe/everforest',
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.everforest_enable_italic = true
      vim.g.everforest_background = 'medium'
      vim.g.everforest_ui_contrast= 'high'
    end
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      require("nightfox").setup({
        options = {
          styles = {
            comments = "italic",
            constants = "bold",
            keywords = "italic",
          },
        }
      })
    end
  },
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make BUILD_FROM_SOURCE=true",
    event = "VeryLazy",
    lazy = true,
    version = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "Kaiser-Yang/blink-cmp-avante",
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      provider = "openrouter",
      providers = {
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "AVANTE_OPENROUTER_API_KEY",
          model = "moonshotai/kimi-k3",
        }
      },
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function(_, _)
      local treesitter = require("nvim-treesitter.configs")
      treesitter.setup({
        ensure_installed = {
          "comment",
          "css",
          "c_sharp",
          "dockerfile",
          "go",
          "graphql",
          "html",
          "http",
          "javascript",
          "jq",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "prisma",
          "python",
          "regex",
          "ruby",
          "rust",
          "scss",
          "sql",
          "terraform",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "cue",
        },
        highlight = { enable = true },
      })
    end
  },
  { 
    "folke/snacks.nvim",
    opts = {
      indent = {
        enabled = true,
        char = "│",
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "outSine",
          duration = {
            step = 40, -- ms per step
            total = 500, -- maximum duration
          },
        },
        ---@class snacks.indent.Scope.Config: snacks.scope.Config
        scope = {
          enabled = true, -- enable highlighting the current scope
          priority = 200,
          char = "│",
          underline = false, -- underline the start of the scope
          only_current = false, -- only show scope in the current window
          hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
        },
        filter = function(buf, win)
          return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
        end,
      },
    }
  },
}

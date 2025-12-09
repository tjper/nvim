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

      vim.cmd.colorscheme("nightfox")
    end
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

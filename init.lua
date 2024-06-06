local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'EdenEast/nightfox.nvim',
    config = function()
      require('nightfox').setup({
        options = {
          -- Compiled file's destination location
          compile_path = vim.fn.stdpath("cache") .. "/nightfox",
          compile_file_suffix = "_compiled", -- Compiled file suffix
          transparent = false,               -- Disable setting background
          terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
          dim_inactive = false,              -- Non focused panes set to alternative background
          styles = {                         -- Style to be applied to different syntax groups
            comments = "italic",             -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "italic",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
          },
          inverse = { -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
          },
          modules = { -- List of various plugins and additional options
            -- ...
          },
        },
        palettes = {},
        specs = {},
        groups = {},
      })

      -- setup must be called before loading
      vim.cmd("colorscheme nightfox")
    end
  },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context' },

  { 
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  },
  { 
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup {
        ensure_installed = { 
          'dockerls',
          'docker_compose_language_service',
          'eslint',
          'golangci_lint_ls',
          'gopls',
          'graphql',
          'tsserver',
          'bashls',
          'tailwindcss',
          'omnisharp',
        },
      }
    end
  },
  { 'neovim/nvim-lspconfig' },
  { 'Hoffs/omnisharp-extended-lsp.nvim' },

  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/nvim-cmp' },

  { 'SirVer/ultisnips' },
  { 'honza/vim-snippets' },
  { 'quangnguyen30192/cmp-nvim-ultisnips' },

  { 'nvim-lua/popup.nvim' },
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require('telescope').load_extension('ultisnips');
    end
  },
  { 'fhill2/telescope-ultisnips.nvim' },

  { 'tpope/vim-fugitive' },
  { 'nvim-lualine/lualine.nvim' },
  { 'nvim-tree/nvim-web-devicons' },
  { 'github/copilot.vim', lazy = true },
  { 'norcalli/nvim-colorizer.lua' },
  { 'lukas-reineke/indent-blankline.nvim' },
  { 'RRethy/vim-illuminate' },

  { 'folke/todo-comments.nvim' },
  { 'folke/which-key.nvim', lazy = true },
  { 'folke/trouble.nvim' },

  { 'junegunn/vim-easy-align' },
  { 'Wansmer/treesj' },

  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },
  { 'tpope/vim-sensible' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-commentary' },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-obsession' },
  { 'mattn/emmet-vim', lazy = true },
})

require('plugins/lspconfig')
require('plugins/treesitter')
require('plugins/cmp')
require('plugins/rest')
require('plugins/trouble')

-- smart search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- tabs are two spaces
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- line break configuration
vim.opt.textwidth = 79
vim.opt.colorcolumn = { 80, 120 }
vim.opt.breakindent = true
vim.opt.linebreak = true

-- set list chars for horizontal scrolling
vim.opt.list = true
vim.opt.listchars:append { tab = "» ", precedes = "<", extends = ">" }

-- built-in completion & tag search
vim.opt.completeopt:append { "menuone", "noinsert" }
vim.opt.complete:remove { "t" }
vim.opt.completefunc = "v:lua.require'snipcomp'" -- custom snippet completion defined in lua/snipcomp.lua

-- show line numbers and highlight cursor line number
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- spell checking
vim.opt.spell = false
vim.opt.spelllang = { "en_us" }

-- mouse and clipboard integration
in_wsl = os.getenv("WSL_DISTRO_NAME") ~= nil
if in_wsl then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = { ["+"] = { "clip.exe" }, ["*"] = { "clip.exe" } },
    paste = {
      ["+"] = { 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))' },
      ["*"] = { 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))' },
    },
    cache_enabled = 0,
  }
end
vim.opt.mouse = "a"

vim.opt.termguicolors = true   -- 24-bit RGB color in the TUI
vim.opt.undofile = true        -- persistent undo history
vim.opt.showmode = false       -- do not show mode message on last line
vim.opt.hidden = true          -- switch buffers without having to save changes
vim.opt.joinspaces = false     -- insert one space when joining two sentences
vim.opt.confirm = true         -- raise dialog asking to save changes when commands like ':q' fail
vim.opt.title = true           -- set terminal window title to something descriptive
vim.opt.foldlevel = 99         -- do not automatically close folds when editing a file
vim.opt.inccommand = "nosplit" -- show incremental changes of commands such as search & replace
vim.opt.virtualedit = "block"  -- virtual editing in visual block mode
vim.opt.shortmess:append("I")  -- don't give intro message when starting vim

-- define leaders for use in keybindings
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
map('n', '<C-F>', '<C-D>', { noremap = true, silent = false })
map('n', '<C-B>', '<C-U>', { noremap = true, silent = false })

map('n', '<leader><leader>', '<cmd>Telescope find_files<cr>', { noremap = true, silent = false })
map('n', '<leader>ag', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = false })
map('n', '<leader>b', '<cmd>Telescope buffers<cr>', { noremap = true, silent = false })
map('n', '<leader>u', '<cmd>Telescope ultisnips<cr>', { noremap = true, silent = false })

-- Open new line below and above current line
map('n', '<leader>o', 'o<esc>', { noremap = true, silent = false })
map('n', '<leader>O', 'O<esc>', { noremap = true, silent = false })

-- Save
map('n', '<leader>w', ':update<cr>', { noremap = true, silent = false })

-- Quit
map('n', '<Leader>q', ':q<cr>', { noremap = true, silent = false })
map('n', '<Leader>Q', ':qa!<cr>', { noremap = true, silent = false })

-- Make Y behave like other capitals
map('n', 'Y', 'y$', { noremap = true, silent = false })

-- qq to record, Q to replay
map('n', 'Q', '@q', { noremap = true, silent = false })

-- Disable highlight when <leader><cr> is pressed
map('n', '<leader><cr>', ':noh<cr>', { noremap = true, silent = true })

-- reload syntax highlighting
map('n', '<F10>', '<Esc>:syntax sync fromstart<CR>', { noremap = true, silent = false })
map('i', '<F10>', '<C-o>:syntax sync fromstart<CR>', { noremap = true, silent = false })

-- search and replace visual selection
map('v', '<C-r>', 'hy:%s/<C-r>h//g<left><left>', { noremap = true, silent = false })

-- window resize shortcuts
map('n', '+', ':exe "resize +15"<CR>', { noremap = true, silent = true });
map('n', '-', ':exe "resize -15"<CR>', { noremap = true, silent = true });
map('n', '<c-m>', ':exe "vertical resize +30"<CR>', { noremap = true, silent = true });
map('n', '<c-n>', ':exe "vertical resize -30"<CR>', { noremap = true, silent = true });

-- neovim terminal
vim.api.nvim_create_user_command('T', 'split | terminal', {})
vim.api.nvim_create_user_command('VT', 'vsplit | terminal', {})

-- delete without yanking
map('n', '<leader>d', '_d', { noremap = true, silent = false });
map('v', '<leader>d', '_d', { noremap = true, silent = false });

-- replace currently selected text with default register without yanking it
map('v', '<leader>p', '_dP', { noremap = true, silent = false });

-- trouble keybindings
map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', { noremap = true, silent = false });
map('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', { noremap = true, silent = false });
map('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', { noremap = true, silent = false });
map('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', { noremap = true, silent = false });
map('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', { noremap = true, silent = false });
map('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', { noremap = true, silent = false });


-- Pulled from https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-config
-- Used to apply the "source.organizeImports" code action in Go files.
function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

local autocmd = vim.api.nvim_create_autocmd

-- On file save, organize imports in Go files.
autocmd('BufWritePre', {
  callback = function()
    go_org_imports()
  end,
})

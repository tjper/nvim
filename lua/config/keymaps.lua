local opts = { noremap = true, silent = true }
local function opt(desc, others)
  return vim.tbl_extend("force", opts, { desc = desc }, others or {})
end

local keymap = vim.keymap.set

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Open new line below and above current line
keymap('n', '<Leader>o', 'o<esc>', opts)
keymap('n', '<Leader>O', 'O<esc>', opts)

-- Save
keymap('n', '<Leader>w', ':update<cr>', opts)

-- Quit
keymap('n', '<Leader>q', ':q<cr>', opts)
keymap('n', '<Leader>Q', ':qa!<cr>', opts)

-- Make Y behave like other capitals
keymap('n', 'Y', 'y$', opts)

-- qq to record, Q to replay
keymap('n', 'Q', '@q', opts)

-- search and replace visual selection
keymap('v', '<C-r>', 'hy:%s/<C-r>h//g<left><left>', opts)

-- window resize shortcuts
keymap('n', '+', ':exe "resize +15"<CR>', opts)
keymap('n', '-', ':exe "resize -15"<CR>', opts)
keymap('n', '<c-m>', ':exe "vertical resize +30"<CR>', opts)
keymap('n', '<c-n>', ':exe "vertical resize -30"<CR>', opts)

-- delete without yanking
keymap('n', '<Leader>d', '_d', opts)
keymap('v', '<Leader>d', '_d', opts)

-- replace currently selected text with default register without yanking it
keymap('v', '<Leader>p', '_dP', opts)

-- neovim terminal
vim.api.nvim_create_user_command('T', 'split | terminal', {})
vim.api.nvim_create_user_command('VT', 'vsplit | terminal', {})

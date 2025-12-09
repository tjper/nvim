local options = {
  backup = false,
  autochdir = false,
  cmdheight = 1,
  conceallevel = 0,
  fileencoding = "utf-8",
  hlsearch = true,
  ignorecase = true,
  mouse = "a",
  pumheight = 10,
  showmode = false,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  termguicolors = true,
  undofile = true,
  updatetime = 300,
  hidden = true,     
  joinspaces = false,
  confirm = true,
  title = true,
  foldlevel = 99,
  inccommand = "nosplit",
  virtualedit = "block",
  list = true,
  spell = false,
  completeopt = {
    "menuone",
    "popup",
    "noselect",
  },

  textwidth = 79,
  colorcolumn = { 80, 120 },
  breakindent = true,
  linebreak = false,

  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,

  number = true,
  relativenumber = true,
  cursorline = true,
  cursorlineopt = "number",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.shortmess:append({ C = true, c = true, I = true })

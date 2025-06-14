local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local cmp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_status_ok then
  return
end

-- Add additional capabilities supported by nvim-cmp
-- See: https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap = true, silent = true }
  vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.format{ async = true }<CR>", opts)
end

-- configure each language server
-- map buffer local keybindings to each language server when attaching
lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = nvim_cmp,
}

lspconfig.ts_ls.setup {
  on_attach = on_attach,
  init_options = {documentFormatting = false},
  capabilities = nvim_cmp,
}

lspconfig.bashls.setup{
  on_attach = on_attach,
  capabilities = nvim_cmp,
}

lspconfig.tailwindcss.setup{
  on_attach = on_attach,
  capabilities = nvim_cmp,
}

local pid = vim.fn.getpid()
lspconfig.omnisharp.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  handlers = {
    ["textDocument/definition"] = require('omnisharp_extended').handler,
  },
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
  -- Enables support for reading code style, naming convention and analyzer
  -- settings from .editorconfig.
  enable_editorconfig_support = true,
  -- If true, MSBuild project system will only load projects for files that
  -- were opened in the editor. This setting is useful for big C# codebases
  -- and allows for faster initialization of code navigation features only
  -- for projects that are relevant to code that is being edited. With this
  -- setting enabled OmniSharp may load fewer projects and may thus display
  -- incomplete reference lists for symbols.
  enable_ms_build_load_projects_on_demand = false,
  -- Enables support for roslyn analyzers, code fixes and rulesets.
  enable_roslyn_analyzers = false,
  -- Specifies whether 'using' directives should be grouped and sorted during
  -- document formatting.
  organize_imports_on_format = true,
  -- Enables support for showing unimported types and unimported extension
  -- methods in completion lists. When committed, the appropriate using
  -- directive will be added at the top of the current file. This option can
  -- have a negative impact on initial completion responsiveness,
  -- particularly for the first few completion sessions after opening a
  -- solution.
  enable_import_completion = true,
  -- Specifies whether to include preview versions of the .NET SDK when
  -- determining which version to use for project loading.
  sdk_include_prereleases = true,
  -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
  -- true
  analyze_open_documents_only = false,
})

lspconfig.golangci_lint_ls.setup {}
lspconfig.eslint.setup({
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

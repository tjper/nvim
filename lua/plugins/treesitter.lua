local treesitter_configs_status_ok, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not treesitter_configs_status_ok then
  return
end

local syntaxes = {
  'comment',
  'c_sharp',
  'dockerfile',
  'go',
  'graphql',
  'html',
  'http',
  'javascript',
  'jq',
  'lua',
  'make',
  'python',
  'regex',
  'ruby',
  'rust',
  'scss',
  'sql',
  'terraform',
  'tsx',
  'typescript',
  'yaml',
}

treesitter_configs.setup({
    ensure_installed = syntaxes,
    highlight = { enable = true },
})

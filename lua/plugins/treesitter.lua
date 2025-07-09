local treesitter_configs_status_ok, treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not treesitter_configs_status_ok then
  return
end

local syntaxes = {
  'comment',
  'css',
  'c_sharp',
  'dockerfile',
  'go',
  'graphql',
  'html',
  'http',
  'javascript',
  'jq',
  'json',
  'lua',
  'make',
  'markdown',
  'markdown_inline',
  'prisma',
  'python',
  'regex',
  'ruby',
  'rust',
  'scss',
  'sql',
  'terraform',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
  'cue',
  'astro',
}

treesitter_configs.setup({
    ensure_installed = syntaxes,
    highlight = { enable = true },
})

local trouble_status_ok, trouble = pcall(require, 'trouble')
if not trouble_status_ok then
  return
end

trouble.setup({
  opts = {}, -- for default options, refer to the configuration section for custom setup.
})

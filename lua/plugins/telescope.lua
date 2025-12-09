return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, opts)
      local telescope = require("telescope.builtin")
      vim.keymap.set('n', '<Leader><Leader>', telescope.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<Leader>ag', telescope.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<Leader>b', telescope.buffers, { desc = 'Telescope buffers' })
    end
  }
}

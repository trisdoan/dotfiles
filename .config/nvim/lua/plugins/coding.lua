return {
  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  -- Search and replace
  {
    "VonHeikemen/searchbox.nvim",
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
    opts = {
      vim.keymap.set('n', '<leader>m', ':SearchBoxIncSearch<CR>')
    }
  },
}

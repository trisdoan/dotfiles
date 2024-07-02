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
      vim.keymap.set("x", "<leader>a", ":SearchBoxIncSearch visual_mode=true<CR>"),
      vim.keymap.set("x", "<leader>A", ":SearchBoxReplace confirm=menu visual_mode=true<CR>"),
    },
  },
}

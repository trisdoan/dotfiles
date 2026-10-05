return {
  -- Docstring generator
  {
    "kkoomen/vim-doge",
    lazy = false,
    keys = {
      {
        "<leader>cp",
        function()
          vim.api.nvim_command("DogeGenerate")
        end,
        desc = "doge generate",
      },
    },
  },
}

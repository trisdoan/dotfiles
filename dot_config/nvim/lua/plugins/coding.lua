return {
  -- Docstring generator
  {
    "kkoomen/vim-doge",
    init = function()
      -- doge's default <leader>d would shadow the no-yank delete in keymaps.lua
      vim.g.doge_mapping = "<leader>cp"
    end,
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
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>y", group = "yank/copy", mode = { "n", "x" } },
      },
    },
  },
}

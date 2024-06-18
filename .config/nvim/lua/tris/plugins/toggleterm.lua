return {
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    keys = {
      {
        mode = { "n", "t", "v" },
        [[<C-`>]],
        "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
        { desc = "Toggle Terminal" },
      },
    },
    version = "*",
    opts = {
      shading_factor = 0.2,
      highlights = { NormalFloat = { link = "NormalFloat" } },
      float_opts = { border = "none" },
    },
  },
}

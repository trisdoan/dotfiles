return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>gv", "<cmd>CodeDiff<cr>", desc = "CodeDiff: review changes" },
    { "<leader>gV", "<cmd>CodeDiff history %<cr>", desc = "CodeDiff: file history" },
    { "<leader>gH", "<cmd>CodeDiff history<cr>", desc = "CodeDiff: repo history" },
  },
  opts = {
    diff = { compact = true, compact_context_lines = 8 },
    explorer = {
      view_mode = "tree",
      width = 50,
      auto_open_on_cursor = true,
      line_stats = { enabled = true },
    },
  },
}

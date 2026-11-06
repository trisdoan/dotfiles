return {
  "stevearc/oil.nvim",
  lazy = false, -- must load at startup to handle `nvim .`
  dependencies = { "nvim-mini/mini.icons" },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Oil: parent directory" },
    {
      "<leader>fo",
      function()
        require("oil").open_float(nil, { preview = {} })
      end,
      desc = "Oil (float + preview)",
    },
  },
  opts = {
    default_file_explorer = true,
    columns = { "icon", "permissions", "size", "mtime" },
    view_options = { show_hidden = true },
    lsp_file_methods = { enabled = true, autosave_changes = true },
    float = { max_width = 200, border = "rounded" },
    keymaps = { ["q"] = "actions.close" },
  },
}

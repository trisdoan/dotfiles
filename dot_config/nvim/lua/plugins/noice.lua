return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.views = vim.tbl_deep_extend("force", opts.views or {}, {
      popup = { enter = true }, -- allow scrolling inside it
    })
    opts.routes = opts.routes or {}
    table.insert(opts.routes, {
      filter = { event = "msg_show", min_width = 80 },
      view = "split",
    })
  end,
}

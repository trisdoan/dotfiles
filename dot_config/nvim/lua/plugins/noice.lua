return {
  "folke/noice.nvim",
  opts = function(_, opts)
    opts.views = vim.tbl_deep_extend("force", opts.views or {}, {
      popup = { enter = true }, -- allow scrolling inside it
    })
    opts.routes = opts.routes or {}
    -- nvim 0.12 emits the write message in two chunks (kind "progress"); the first is just the quoted path, and a long one hits the min_width split below
    table.insert(opts.routes, {
      filter = { event = "msg_show", kind = "progress", find = '^"[^"]+"' },
      view = "mini",
    })
    table.insert(opts.routes, {
      filter = { event = "msg_show", min_width = 80 },
      view = "split",
    })
  end,
}

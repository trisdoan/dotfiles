return {
  "folke/noice.nvim",
  opts = {
    views = {
      popup = {
        enter = true, -- allow you to scroll inside it
      },
      routes = {
        {
          filter = { event = "msg_show", min_width = 80 },
          view = "split",
        },
      },
    },
  },
}

return {
  "folke/snacks.nvim",
  opts = {
    explorer = { replace_netrw = false },
    dashboard = {
      preset = {
        header = [[

          ████████╗██████╗ ██╗███████╗    ██████╗  ██████╗  █████╗ ███╗   ██╗
          ╚══██╔══╝██╔══██╗██║██╔════╝    ██╔══██╗██╔═══██╗██╔══██╗████╗  ██║
             ██║   ██████╔╝██║███████╗    ██║  ██║██║   ██║███████║██╔██╗ ██║
             ██║   ██╔══██╗██║╚════██║    ██║  ██║██║   ██║██╔══██║██║╚██╗██║
             ██║   ██║  ██║██║███████║    ██████╔╝╚██████╔╝██║  ██║██║ ╚████║
             ╚═╝   ╚═╝  ╚═╝╚═╝╚══════╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝
             ]],
      },
    },
    picker = {
      hidden = true,
      ignored = true,
      exclude = { -- add folder names here to exclude
        ".git",
        "node_modules",
      },
    },
    image = {
      enabled = true,
      doc = {
        inline = true,
      },
    },
  },
}

return {
  {
    "stevearc/conform.nvim",
    opts = function()
      local opts = {
        formatters_by_ft = {
          xml = { "xmllint" },
        },
      }
      return opts
    end,
  },
}

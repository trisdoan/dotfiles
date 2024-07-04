return {
  {
    "stevearc/conform.nvim",
    opts = function()
      local opts = {
        formatters_by_ft = {
          xml = { "xmllint"},
          python = { "black", "flake8", "ruff"},
          javascript = {"prettier"},
        },
      }
      return opts
    end,
  },
}

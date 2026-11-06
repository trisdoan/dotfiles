return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters.prettier = {
        command = "prettier",
        args = { "--stdin-filepath", "$FILENAME" },
      }
      opts.formatters_by_ft.javascript = { "prettier" }
      opts.formatters_by_ft.xml = { "xmlformatter" }
      opts.formatters_by_ft.python = { "ruff_organize_imports", "ruff_format" }
      opts.formatters_by_ft.css = { "prettier" }
      opts.formatters_by_ft.scss = { "prettier" }

      return opts
    end,
  },
}

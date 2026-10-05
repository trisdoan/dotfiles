return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters.prettier = {
        command = "prettier",
        args = { "--stdin-filepath", "$FILENAME" },
      }
      -- 1. Add formatters by filetype
      opts.formatters_by_ft.javascript = { "prettier" }
      opts.formatters_by_ft.xml = { "xmlformatter" }
      opts.formatters_by_ft.python = { "black", "flake8" }
      opts.formatters_by_ft.css = { "prettier" }
      opts.formatters_by_ft.scss = { "prettier" }

      -- 2. Add or override custom formatter behavior
      -- opts.formatters = opts.formatters or {}
      -- opts.formatters.prettier = {
      --   -- Example: only use Prettier if a config file exists, or always
      --   condition = function(_, ctx)
      --     -- you can use vim.g.lazyvim_prettier_needs_config or always return true
      --     return true
      --   end,
      -- }

      -- Optionally, pass extra command-line arguments
      -- opts.formatters.prettier.prepend_args = { "--single-quote" }

      return opts
    end,
  },
}

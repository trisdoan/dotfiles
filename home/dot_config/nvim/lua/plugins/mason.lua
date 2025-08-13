return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "prettier",
        -- "black",
        -- "flake8",
        "xmlformatter",
        "ruff",
      },
    },
  },
}

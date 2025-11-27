-- ~/.config/nvim/lua/plugins/odoo-lsp.lua
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")
    local util = require("lspconfig.util")

    -- Register custom config FIRST
    if not configs.odoo_lsp then
      configs.odoo_lsp = {
        default_config = {
          name = "odoo-lsp",
          cmd = { "odoo-lsp" }, -- must be on PATH
          filetypes = { "python", "javascript", "typescript", "xml" },
          root_dir = util.root_pattern(".odoo_lsp", ".odoo_lsp.json", ".git"),
        },
      }
    end

    -- Then merge it into LazyVim's LSP opts
    opts.servers = opts.servers or {}
    opts.servers.odoo_lsp = {
      cmd = { "odoo-lsp" },
      filetypes = { "python", "javascript", "typescript", "xml" },
    }

    return opts
  end,
}

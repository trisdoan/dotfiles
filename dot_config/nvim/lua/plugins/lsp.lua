return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    if vim.fn.executable("odoo-lsp") == 0 then
      return
    end
    opts.servers = opts.servers or {}
    opts.servers.odoo_lsp = {
      mason = false,
      cmd = { "odoo-lsp" },
      filetypes = { "python", "javascript", "xml" },
      root_markers = { ".odoo_lsp", ".odoo_lsp.json", ".git" },
    }
  end,
}

return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        --typescript = { "prettier" },
        javascriptreact = { "prettier" },
        --typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        --yaml = { "prettier" },
        markdown = { "prettier" },
        --graphql = { "prettier" },
        --liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black", "flake8", "ruff" },
        --xml = { "xmlformat" },
      },
      format_on_save = function(bufnr) 
        -- Disable autoformat on certain filetypes
        local ignore_filetypes = { "yml", "xml"}
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        -- Disable autoformat for files in certain path
        -- local bufname - vim.api.nvim_buf_get_name(bufnr)
        -- if bufname:match("/node_modules/") then
        --  return
        -- end
        return { timeout_ms = 1000, lsp_fallback = true , async=false,}
    end,
    })
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}

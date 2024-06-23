return {
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    keys = {
      {
        mode = { "n", "t", "v" },
        [[<C-`>]],
        "<cmd>ToggleTerm size=15 direction=horizontal<cr>",
        { desc = "Toggle Terminal" },
      },
    },
    version = "*",
    opts = {
      autochdir = false,
    },
    config = function()
      require("toggleterm").setup()
      --local Terminal = require("toggleterm.terminal").Terminal
      --local colors = require("tris.core.colors").colors
      --local defaults = {
      --  direction = "float",
      --  float_opts = {
      --    border = "single",
      --  },
      --  shade_terminals = false,
      --  highlights = {
      --    Normal = {
      --      guibg = colors.grey14,
      --    },
      --    FloatBorder = {
      --      guibg = colors.grey14,
      --      guifg = colors.grey14,
      --    },
      --  },
      --}
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
        vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd("autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()")
      vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

      -- local lazygit = Terminal:new({ cmd = "lazygit", hidden = true }, defaults)

      -- function _lazygit_toggle()
      --   lazygit:toggle()
      -- end
      -- vim.api.nvim_set_keymap(
      --   "n",
      --   "<leader>g",
      --   "<cmd>lua _lazygit_toggle()<CR>",
      --   { noremap = true, silent = true, desc = "Open lazygit" }
      -- )
    end,
  },
}

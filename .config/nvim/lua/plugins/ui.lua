-- greeter
return {

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[

          ████████╗██████╗ ██╗███████╗    ██████╗  ██████╗  █████╗ ███╗   ██╗
          ╚══██╔══╝██╔══██╗██║██╔════╝    ██╔══██╗██╔═══██╗██╔══██╗████╗  ██║
             ██║   ██████╔╝██║███████╗    ██║  ██║██║   ██║███████║██╔██╗ ██║
             ██║   ██╔══██╗██║╚════██║    ██║  ██║██║   ██║██╔══██║██║╚██╗██║
             ██║   ██║  ██║██║███████║    ██████╔╝╚██████╔╝██║  ██║██║ ╚████║
             ╚═╝   ╚═╝  ╚═╝╚═╝╚══════╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝
             ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  ----- THEME -----
  -- {
  --   "oxfist/night-owl.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("night-owl").setup()
  --     vim.cmd.colorscheme("night-owl")
  --   end,
  -- },

  -- {
  --   "zenbones-theme/zenbones.nvim",
  --   -- Optionally install Lush. Allows for more configuration or extending the colorscheme
  --   -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
  --   -- In Vim, compat mode is turned on as Lush only works in Neovim.
  --   dependencies = "rktjmp/lush.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   -- you can set set configuration options here
  --    config = function()
  --        -- vim.g.zenbones_darken_comments = 45
  --        vim.cmd.colorscheme('lunaperche')
  --    end
  -- },

   {
     "LazyVim/LazyVim",
     opts = {
       colorscheme = "lunaperche",
     },
   },

  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     flavour = "latte",
  --   },
  --   config = function(plugin, opts)
  --     opts = {
  --       --flavour = "auto", -- latte, frappe, macchiato, mocha
  --       background = { -- :h background
  --         light = "latte",
  --         dark = "mocha",
  --       },
  --       transparent_background = true, -- disables setting the background color.
  --       --show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
  --       --term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
  --       --dim_inactive = {
  --       --  enabled = false, -- dims the background color of inactive window
  --       --  shade = "dark",
  --       --  percentage = 0.15, -- percentage of the shade to apply to the inactive window
  --       --},
  --       --no_italic = false, -- Force no italic
  --       --no_bold = false, -- Force no bold
  --       --no_underline = false, -- Force no underline
  --       --styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
  --       --  comments = { "italic" }, -- Change the style of comments
  --       --  conditionals = { "italic" },
  --       --  loops = {},
  --       --  functions = {},
  --       --  keywords = {},
  --       --  strings = {},
  --       --  variables = {},
  --       --  numbers = {},
  --       --  booleans = {},
  --       --  properties = {},
  --       --  types = {},
  --       --  operators = {},
  --       --  -- miscs = {}, -- Uncomment to turn off hard-coded styles
  --       --},
  --       --color_overrides = {},
  --       --custom_highlights = {},
  --       --default_integrations = true,
  --       --integrations = {
  --       --  cmp = true,
  --       --  gitsigns = true,
  --       --  nvimtree = true,
  --       --  treesitter = true,
  --       --  notify = false,
  --       --  mini = {
  --       --    enabled = true,
  --       --    indentscope_color = "",
  --       --  },
  --       --},
  --     }
  --     require(plugin.name).setup(opts)
  --     --vim.opt.background = "dark"
  --     vim.cmd.colorscheme("catppuccin")
  --   end,
  -- },

  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      --opts.presets.lsp_doc_border = true
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 5000,
    },
  },
  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "Close Buffer" },
    },
    opts = {
      options = {
        mode = "buffers",
      },
    },
  },
}

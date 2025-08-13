return {

  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup({
        keymaps = {
          toggle = {
            normal = "<leader>oc",
          },
        },
      })
    end,
  },

  {
    "jonroosevelt/gemini-cli.nvim",
    config = function()
      require("gemini").setup({
        -- NOTE: keymap to open buffe: <leader>og
        split_direction = "vertical", -- optional: "vertical" (default) or "horizontal"
      })
    end,
  },
  -- {
  --   "azorng/goose.nvim",
  --   config = function()
  --     require("goose").setup({
  --       keymap = {
  --         global = {
  --           toggle = "<leader>ag", -- Open goose. Close if opened
  --           open_input = "<leader>ai", -- Opens and focuses on input window on insert mode
  --           open_input_new_session = "<leader>aI", -- Opens and focuses on input window on insert mode. Creates a new session
  --           open_output = "<leader>ao", -- Opens and focuses on output window
  --           toggle_focus = "<leader>at", -- Toggle focus between goose and last window
  --           close = "<leader>aq", -- Close UI windows
  --           toggle_fullscreen = "<leader>af", -- Toggle between normal and fullscreen mode
  --           select_session = "<leader>as", -- Select and load a goose session
  --           goose_mode_chat = "<leader>amc", -- Set goose mode to `chat`. (Tool calling disabled. No editor context besides selections)
  --           goose_mode_auto = "<leader>ama", -- Set goose mode to `auto`. (Default mode with full agent capabilities)
  --           configure_provider = "<leader>ap", -- Quick provider and model switch from predefined list
  --           diff_open = "<leader>ad", -- Opens a diff tab of a modified file since the last goose prompt
  --           diff_next = "<leader>a]", -- Navigate to next file diff
  --           diff_prev = "<leader>a[", -- Navigate to previous file diff
  --           diff_close = "<leader>ac", -- Close diff view tab and return to normal editing
  --           diff_revert_all = "<leader>ara", -- Revert all file changes since the last goose prompt
  --           diff_revert_this = "<leader>art", -- Revert current file changes since the last goose prompt
  --         },
  --       },
  --     })
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     {
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         anti_conceal = { enabled = false },
  --       },
  --     },
  --   },
  -- },

  -- {
  --   "yetone/avante.nvim",
  --   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  --   -- ⚠️ must add this setting! ! !
  --   build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
  --     or "make",
  --   event = "VeryLazy",
  --   version = false, -- Never set this value to "*"! Never!
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     -- add any opts here
  --     -- this file can contain specific instructions for your project
  --     instructions_file = "avante.md",
  --     -- for example
  --     provider = "gemini",
  --     providers = {
  --       gemini = {
  --         api_key_name = "cmd:bw get notes gemini-api-key",
  --         model = "gemini-2.5-pro",
  --         timeout = 3000,
  --       },
  --       claude = {
  --         endpoint = "https://api.anthropic.com",
  --         model = "claude-sonnet-4-20250514",
  --         api_key_name = "cmd:bw get notes claude-api-key",
  --         timeout = 30000, -- Timeout in milliseconds
  --         extra_request_body = {
  --           temperature = 0.75,
  --           max_tokens = 20480,
  --         },
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     --- The below dependencies are optional,
  --     "echasnovski/mini.pick", -- for file_selector provider mini.pick
  --     "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
  --     "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --     "ibhagwan/fzf-lua", -- for file_selector provider fzf
  --     "stevearc/dressing.nvim", -- for input provider dressing
  --     "folke/snacks.nvim", -- for input provider snacks
  --     "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --     -- "zbirenbaum/copilot.lua", -- for providers='copilot'
  --     {
  --       -- support for image pasting
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         -- recommended settings
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = {
  --             insert_mode = true,
  --           },
  --         },
  --       },
  --     },
  --     {
  --       -- Make sure to set this up properly if you have lazy=true
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         file_types = { "markdown", "Avante" },
  --       },
  --       ft = { "markdown", "Avante" },
  --     },
  --   },
  -- },
}

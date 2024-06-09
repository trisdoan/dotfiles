return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
    --"nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local transform_mod = require("telescope.actions.mt").transform_mod

    local trouble = require("trouble")
    local trouble_telescope = require("trouble.providers.telescope")

    -- or create your custom action
    --local custom_actions = transform_mod({
    --  open_trouble_qflist = function(prompt_bufnr)
    --    trouble.toggle("quickfix")
    --  end,
    --})

    telescope.setup({
      defaults = {
        path_display = { "smart" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            -- ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
            --["<C-t>"] = trouble_telescope.smart_open_with_trouble,
          },
        },
      },
      previewer = true,
      layout_config = {
        prompt_position = "top",
        preview_cutoff = 120,
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },
        --["ui-select"] = {
        --  require("telescope.themes").get_dropdown({
        --    previewer = false,
        --    initial_mode = "normal",
        --    sorting_strategy = "ascending",
        --    layout_strategy = "horizontal",
        --    layout_config = {
        --      horizontal = {
        --        width = 0.5,
        --        height = 0.4,
        --        preview_width = 0.6,
        --      },
        --    },
        --  }),
        --},
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("file_browser")
    --telescope.load_extension("ui-select")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>sB", ":Telescope file_browser path=%:p:h=%:p:h<cr>", { desc = "Browse Files" }) -- Added keymap for file browser
  end,
}

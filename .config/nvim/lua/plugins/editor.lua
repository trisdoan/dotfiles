return {
  {
    enabled = false,
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      search = {
        forward = true,
        multi_window = false,
        wrap = false,
        incremental = true,
      },
    },
  },

    {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-project.nvim",
    },
    keys = {
      -- disable the keymap to grep files
      { "<leader>/", false },
      --{
      --  "<leader>fP",
      --  function()
      --    require("telescope.builtin").find_files({
      --      cwd = require("lazy.core.config").options.root,
      --    })
      --  end,
      --  desc = "Find Plugin File",
      --},
      {
        ";f",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({
            no_ignore = false,
            hidden = true,
            file_ignore_patterns = {'node_modules', '.git', 'min.js'} -- ignore ext jslib
          })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";r",
        function()
          local builtin = require("telescope.builtin")
          builtin.live_grep({
            additional_args = { "--hidden" },
          })
        end,
        desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      },
      {
        "\\\\",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";t",
        function()
          local builtin = require("telescope.builtin")
          builtin.help_tags()
        end,
        desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
      },
      {
        ";;",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      {
        ";e",
        function()
          local builtin = require("telescope.builtin")
          builtin.diagnostics()
        end,
        desc = "Lists Diagnostics for all open buffers or a specific buffer",
      },
      {
        ";s",
        function()
          local builtin = require("telescope.builtin")
          builtin.treesitter()
        end,
        desc = "Lists Function names, variables, from Treesitter",
      },
      {
        "sf",
        function()
          local telescope = require("telescope")

          local function telescope_buffer_dir()
            return vim.fn.expand("%:p:h")
          end

          telescope.extensions.file_browser.file_browser({
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = { height = 40 },
          })
        end,
        desc = "Open File Browser with the path of the current buffer",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          n = {},
        },
      })
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
      }
      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            -- your custom insert mode mappings
            ["n"] = {
              -- your custom normal mode mappings
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
      }
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("project")
    end,
    vim.api.nvim_set_keymap(
      "n",
      "<C-p>",
      ":lua require'telescope'.extensions.project.project{}<CR>",
      { noremap = true, silent = true }
    ),
  },
  --- Terminal
  {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
   config = function()
      require("toggleterm").setup({
        open_mapping = [[<C-\>]],
        shading_factor = "5",
      })

      -- Counts existing terminal
      function CountTerms()
        local buffers = vim.api.nvim_list_bufs()
        local terminal_count = 0

        for _, buf in ipairs(buffers) do
          if vim.bo[buf].buftype == 'terminal' then
            terminal_count = terminal_count + 1
          end
        end
        return terminal_count
      end
      
      -- Floating terminal
      vim.keymap.set("n", "<C-]>", ":ToggleTerm direction=float<cr>", { desc = "Float Terminal" })
      vim.keymap.set("t", "<C-]>",
        function()
          vim.cmd("ToggleTerm")
        end,
        { noremap = true, silent = true, desc = "Close Floating Terminal" })
      
      -- Horizontal terminal
      vim.keymap.set("n", "<C-`>", ":ToggleTerm direction=horizontal<cr>",{
        noremap=true, silent=true, desc="Horizontal Terminal"
      })
      
      -- Create new terminals
      vim.keymap.set("n", "<leader>tt", function()
        local command = CountTerms() + 1 .. "ToggleTerm"
        vim.cmd(command)
      end, { desc = "Toggle terminal" })

      --- Close current terminal
      vim.keymap.set("n", "<leader>tq", function()
        if CountTerms() == 0 then
          return
        end
        vim.api.nvim_win_close(vim.api.nvim_get_current_win(), false)
      end, { noremap = true, silent = true, desc="Exist current terminal"})


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
    end,
  },
}

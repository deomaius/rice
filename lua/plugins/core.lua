--- deo's nvim rice ---

return {
  -------------------------
  {
    "slugbyte/lackluster.nvim",
    opts = {
      lazy = true,
      priority = 1000,
      init = function()
        -- vim.cmd.colorscheme("lackluster")
        vim.cmd.colorscheme("lackluster-hack") -- my favorite
        -- vim.cmd.colorscheme("lackluster-mint")
      end,
    },
  },
  -------------------------
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "lackluster-hack",
    },
  },
  -------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  -------------------------
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  -------------------------
  -------------------------
  {
    "nvim-telescope/telescope.nvim",
    keys = {
    -- add a keymap to browse plugin files
    -- stylua: ignore
    {
      "<leader>fp",
      function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
      desc = "Find Plugin File",
    },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            -- Always open in vertical split if possible, let vim handle the positioning
            ["<CR>"] = function(prompt_bufnr)
              local actions = require("telescope.actions")
              -- Close telescope first
              actions.close(prompt_bufnr)
              -- Get the selected entry
              local entry = require("telescope.actions.state").get_selected_entry()
              if entry then
                -- Create vertical split and open the file
                vim.cmd("vsplit " .. entry.path)
              end
            end,
            -- Keep normal vertical split available with Ctrl+V
            ["<C-v>"] = require("telescope.actions").file_vsplit,
            -- Keep normal horizontal split with Ctrl+X
            ["<C-x>"] = require("telescope.actions").file_split,
            -- Add option to open in same window
            ["<C-CR>"] = require("telescope.actions").select_default,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              local actions = require("telescope.actions")
              actions.close(prompt_bufnr)
              local entry = require("telescope.actions.state").get_selected_entry()
              if entry then
                vim.cmd("vsplit " .. entry.path)
              end
            end,
            ["<C-v>"] = require("telescope.actions").file_vsplit,
            ["<C-x>"] = require("telescope.actions").file_split,
            ["<C-CR>"] = require("telescope.actions").select_default,
          },
        },
      },
    },
    config = function()
      -- Ensure splitright is set for vertical splits to go right
      vim.opt.splitright = true
      vim.opt.splitbelow = true

      require("telescope").load_extension("noice")
    end,
  },
  -------------------------
  {
    "nvim-telescope/telescope.nvim",
    keys = {
    -- add a keymap to browse plugin files
    -- stylua: ignore
    {
      "<leader>fp",
      function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
      desc = "Find Plugin File",
    },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = {
          i = {
            ["<CR>"] = function(prompt_bufnr)
              local actions = require("telescope.actions")
              -- Check if we have normal file buffers open (not just command/telescope windows)
              local normal_wins = 0
              for i = 1, vim.fn.winnr("$") do
                local bufnr = vim.fn.winbufnr(i)
                local buftype = vim.fn.getbufvar(bufnr, "&buftype")
                local filetype = vim.fn.getbufvar(bufnr, "&filetype")
                -- Count windows with normal files (not telescope, command, etc.)
                if buftype == "" and filetype ~= "telescope" then
                  normal_wins = normal_wins + 1
                end
              end

              if normal_wins <= 1 then
                -- If only one normal file window, open normally
                actions.select_default(prompt_bufnr)
              else
                -- If multiple normal file windows, open in vertical split (right panel)
                actions.file_vsplit(prompt_bufnr)
              end
            end,
            -- Keep normal vertical split available with Ctrl+V
            ["<C-v>"] = require("telescope.actions").file_vsplit,
            -- Keep normal horizontal split with Ctrl+X
            ["<C-x>"] = require("telescope.actions").file_split,
          },
          n = {
            ["<CR>"] = function(prompt_bufnr)
              local actions = require("telescope.actions")
              -- Same logic for normal mode
              local normal_wins = 0
              for i = 1, vim.fn.winnr("$") do
                local bufnr = vim.fn.winbufnr(i)
                local buftype = vim.fn.getbufvar(bufnr, "&buftype")
                local filetype = vim.fn.getbufvar(bufnr, "&filetype")
                if buftype == "" and filetype ~= "telescope" then
                  normal_wins = normal_wins + 1
                end
              end

              if normal_wins <= 1 then
                actions.select_default(prompt_bufnr)
              else
                actions.file_vsplit(prompt_bufnr)
              end
            end,
            ["<C-v>"] = require("telescope.actions").file_vsplit,
            ["<C-x>"] = require("telescope.actions").file_split,
          },
        },
      },
    },
    config = function()
      -- Ensure splitright is set for vertical splits to go right
      vim.opt.splitright = true
      vim.opt.splitbelow = true

      require("telescope").load_extension("noice")
    end,
  },
  -------------------------
  { import = "lazyvim.plugins.extras.lang.typescript" },
  -------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },
  -------------------------
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts) end,
  },
  -------------------------
  { import = "lazyvim.plugins.extras.ui.mini-starter" },
  -------------------------
  { import = "lazyvim.plugins.extras.lang.json" },
  -------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  -------------------------
}

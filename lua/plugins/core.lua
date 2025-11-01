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
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
    },
  },
  -------------------------
}

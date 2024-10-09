return {
  {
    "akinsho/bufferline.nvim",
    version = false,
    opts = {},
    config = function()
      require("bufferline").setup({
        options = {
          show_buffer_icons = false,
          separator_style = { "", "" },
        },
      })
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
  },
}

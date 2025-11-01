return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    opts = {
      indent = {
        enabled = false,
      },
      picker = {
        sources = {
          explorer = {
            layout = {
              auto_hide = { "input" },
            },
          },
        },
      },
    },
  },
}

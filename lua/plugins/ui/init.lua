return {
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    opts = {},
  },
  {
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "120",
      disabled_filetypes = { "help", "text", "markdown", "alpha" },
      limit_to_window = false,
    },
  },

  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      animate = {
        enabled = true,
        fps = 100, -- frames per second
        cps = 220,
      }, -- ce
    },
  },
}

require("telescope").load_extension("noice")

require("telescope").load_extension("harpoon")
return {
  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {},
    },
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
      { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
      { "<leader>fw", require("lazyvim.util").telescope("live_grep"), desc = "Find in Files (Grep)" },
      {
        "<leader>fW",
        '<cmd>lua require("telescope.builtin").live_grep({grep_open_files=true})<CR>',
        desc = "Grep Buffers",
      },
      { "<leader>fB", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
      { "<leader>sP", "<cmd>Telescope harpoon marks<cr>", desc = "Harpoon Marks" },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  {
    "m-demare/hlargs.nvim",
    event = "LspAttach",
    opts = {},
  },
}

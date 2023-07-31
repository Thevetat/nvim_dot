return {
  {
    "ThePrimeagen/harpoon",
    keys = {
      { "<leader>hm", '<cmd>lua require("harpoon.mark").add_file()<cr>', desc = "Harpoon" },
      { "<leader>h.", '<cmd>lua require("harpoon.ui").nav_next()<cr>', desc = "Harpoon Next" },
      { "<leader>h,", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', desc = "Harpoon Prev" },
      { "<leader>h;", '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', desc = "Harpoon UI" },
      { "<leader>h1", '<cmd>lua require("harpoon.ui").nav_file(1) <CR> ', desc = "Harpoon File 1" },
      { "<leader>h2", '<cmd>lua require("harpoon.ui").nav_file(2) <CR> ', desc = "Harpoon File 2" },
      { "<leader>h3", '<cmd>lua require("harpoon.ui").nav_file(3) <CR> ', desc = "Harpoon File 3" },
      { "<leader>h4", '<cmd>lua require("harpoon.ui").nav_file(4) <CR> ', desc = "Harpoon File 4" },
      { "<leader>h5", '<cmd>lua require("harpoon.ui").nav_file(5) <CR> ', desc = "Harpoon File 5" },
      { "<leader>h6", '<cmd>lua require("harpoon.ui").nav_file(6) <CR> ', desc = "Harpoon File 6" },
    },
  },
}

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "rouge8/neotest-rust",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npx jest --watch",
            jestConfigFile = "custom.jest.config.ts",
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          }),
          require("neotest-rust"),
          require("neotest-vitest"),
          require("neotest-go"),
        },
      })
    end,
    keys = {
      { "<leader>lta", '<cmd> lua require("neotest").run.attach() <CR> ', desc = "Toggle NeoTest" },
      { "<leader>ltt", '<cmd> lua require("neotest").summary.toggle() <CR> ', desc = "Toggle NeoTest" },
      { "<leader>ltr", '<cmd> lua require("neotest").run.run() <CR>', desc = "Start Nearest Test" },
      { "<leader>lts", '<cmd> lua require("neotest").run.stop() <CR>', desc = "Stop Nearest Test" },
    },
  },
}

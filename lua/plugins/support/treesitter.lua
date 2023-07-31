local server_list = require("config.server_list")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "BufReadPre",
      },
      -- {
      --   "p00f/nvim-ts-rainbow",
      --   event = "BufReadPre",
      -- },
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "BufReadPre",
      },
    },
    opts = {
      autopairs = {
        enable = true,
      },

      autotag = {
        enable = true,
        filetypes = server_list.ts_autotag_filetypes,
      },

      ensure_installed = server_list.ts_ensure_installed,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "markdown" },
      },

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
        config = {
          typescript = "// %s",
          css = "/* %s */",
          scss = "/* %s */",
          html = "<!-- %s -->",
          svelte = "<!-- %s -->",
          vue = "<!-- %s -->",
          json = "",
        },
      },

      matchup = {
        enable = true,
      },

      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = true, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },

      -- rainbow = {
      --   enable = true,
      --   extended_mode = true,
      --   colors = {
      --     "#c678dd",
      --     "#61afef",
      --     "#43ac80",
      --     "#e5c07b",
      --     "#56b6c2",
      --     "#d074ec",
      --     "#ffd700",
      --   },
      --   max_file_lines = 1000,
      -- },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    config = true,
    event = "BufReadPre",
  },

  {
    "windwp/nvim-autopairs",
    config = true,
    event = "BufReadPre",
  },

  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}

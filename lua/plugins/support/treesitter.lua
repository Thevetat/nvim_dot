local server_list = require("config.server_list")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

      { "https://gitlab.com/HiPhish/nvim-ts-rainbow2" },
      { "nvim-treesitter/nvim-treesitter-textobjects" },

      {
        "JoosepAlviste/nvim-ts-context-commentstring",
        ft = { "vue" },
      },

      {
        "windwp/nvim-ts-autotag",
        opts = {
          enable_close_on_slash = false,
          filetypes = {
            "html",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
            "xml",
          },
        },
      },

      {
        "windwp/nvim-autopairs",
        config = true,
      },
    },
    config = function()
      vim.opt.foldmethod = "expr" -- use function to determine folds
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- use treesitter for folding

      require("nvim-treesitter.configs").setup({
        -- either "all" or a list of languages
        ensure_installed = "all",
        autopairs = {
          enable = true,
        },
        highlight = {
          -- false will disable the whole extension
          enable = true,
          additional_vim_regex_highlighting = { "markdown" },
        },
        indent = {
          enable = false, -- buggy :/
        },
        -- custom text objects
        textobjects = {
          -- change/delete/select in function or class
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
            },
          },
          -- easily move to next function/class
          move = {
            enable = true,
            set_jumps = true, -- track in jumplist (<C-o>, <C-i>)
            goto_next_start = {
              ["]["] = "@function.outer",
              [")("] = "@class.outer",
            },
            goto_next_end = {
              ["]]"] = "@function.outer",
              ["))"] = "@class.outer",
            },
            goto_previous_start = {
              ["[["] = "@function.outer",
              ["(("] = "@class.outer",
            },
            goto_previous_end = {
              ["[]"] = "@function.outer",
              ["()"] = "@class.outer",
            },
          },
          -- peek definitions from LSP
          lsp_interop = {
            enable = true,
            border = "single",
            peek_definition_code = {
              ["<Leader>pf"] = "@function.outer",
              ["<Leader>pc"] = "@class.outer",
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<Leader>l"] = "@parameter.inner",
            },
            swap_previous = {
              ["<Leader>h"] = "@parameter.outer",
            },
          },
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false, -- Comment.nvim takes care of this automatically
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

        rainbow = {
          enable = true,
          -- Which query to use for finding delimiters
          query = {
            "rainbow-parens", -- parentheses by default
            html = "rainbow-tags", -- tags for html
          },
          -- Highlight the entire buffer all at once
          strategy = require("ts-rainbow.strategy.global"),
        },

        autotag = {
          enable = true,
          filetypes = { "html", "vue" },
        },
      })
    end,
  },
}

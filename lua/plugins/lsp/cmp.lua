return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "lukas-reineke/cmp-rg",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
      "SmiteshP/nvim-navic",
      "hrsh7th/cmp-cmdline",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

      local has_words_before = function()
        if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
          return false
        end
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
      end

      cmp.setup({
        preselect = cmp.PreselectMode.None,
        completion = { completeopt = "noselect" },
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered({
            col_offset = -3,
          }),
        },

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },

        formatting = {
          exapandable_indicator = true,

          format = lspkind.cmp_format({
            mode = "symbol_text",
            preset = "default",
            maxwidth = 50,
            ellipsis_char = "...",
            symbol_map = { Copilot = "🤖" },
            menu = {
              copilot = "🤖",
              luasnip = "✂️",
              nvim_lsp = "🔍",
              emoji = "(Emoji)",
              path = "📂",
              calc = "🤓",
              cmp_tabnine = "(Tabnine)",
              buffer = "🐃",
              tmux = "(TMUX)",
              treesitter = "🌲",
              crates = "🥡",
              neorg = "neorg",
            },
          }),
        },

        sources = {
          { name = "copilot", group_index = 2 },
          { name = "nvim_lsp", keyword_length = 2, trigger_characters = { "-" } },
          { name = "nvim_lsp_signature_help", keyword_length = 2 },
          { name = "luasnip", keyword_length = 2 },
          { name = "copilot" },
          { name = "path" },
          { name = "buffer", keyword_length = 3 },
          { name = "treesitter", keyword_length = 3 },
          { name = "crates" },
          { name = "nvim_lua" },
          { name = "spell" },
          { name = "emoji" },
          { name = "calc" },
          { name = "neorg" },
        },

        mapping = {
          -- Navigation Of Completion Menu --
          ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(cmp_select_opts), { "i", "c" }),
          ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(cmp_select_opts), { "i", "c" }),

          -- Scroll Docs --
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(5), { "i", "c" }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-5), { "i", "c" }),

          ["<C-Space>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.close()
              fallback()
            else
              cmp.complete()
            end
          end),

          ["<C-e>"] = cmp.mapping.abort(),

          ["<Enter>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
          }),

          ["<Tab>"] = function(fallback)
            if cmp.visible() and has_words_before() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            elseif luasnip.expand_or_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            else
              fallback()
            end
          end,

          ["<S-Tab>"] = function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            else
              fallback()
            end
          end,

          -- Go To The Next Placeholder In The Snippet
          ["<C-n>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          -- Go To The Next Placeholder In The Snippet
          ["<C-b>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      local types = require("luasnip.util.types")

      luasnip.config.set_config({
        history = true,
        update_events = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged",
        enable_autosnippets = false,
        ext_opts = {
          [types.choiceNode] = {
            active = {
              virt_text = { { "<- Choice" } },
            },
          },
        },
      })

      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/rust" } })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/quasar" } })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/lua" } })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/d2" } })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/go" } })
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/markdown" } })

      local node_path = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v16.19.0/bin/node"
      if vim.loop.fs_stat(node_path) then
        require("copilot_cmp").setup({
          formatters = {
            insert_text = require("copilot_cmp.format").remove_existing,
          },
        })
        vim.defer_fn(function()
          require("copilot").setup({
            copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v16.19.0/bin/node",
            plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
            -- filetypes = {
            --   go = true,
            -- },
          })
        end, 100)
      end
    end,

    event = { "InsertEnter", "CmdlineEnter" },
  },
}

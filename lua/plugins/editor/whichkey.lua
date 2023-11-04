return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
    },
    config = function(_, opts)
      local Util = require("lazyvim.util")

      local icons = require("config.ui.icons")

      local options = {
        active = true,
        on_config_done = nil,
        setup = {
          plugins = {
            marks = false, -- shows a list of your marks on ' and `
            registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
              operators = true, -- adds help for operators like d, y, ...
              motions = true, -- adds help for motions
              text_objects = false, -- help for text objects triggered after entering an operator
              windows = true, -- default bindings on <c-w>
              nav = false, -- misc bindings to work with windows
              z = true, -- bindings for folds, spelling and others prefixed with z
              g = true, -- bindings for prefixed with g
            },
            spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
          },
          icons = {
            breadcrumb = icons.ui.DoubleChevronRight, -- symbol used in the command line area that shows your active key combo
            separator = icons.ui.BoldArrowRight, -- symbol used between a key and it's label
            group = icons.ui.Plus, -- symbol prepended to a group
          },
          popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
          },
          window = {
            border = "single", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,
          },
          layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "left", -- align columns left, center or right
          },
          hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
          ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
          show_help = true, -- show help message on the command line when the popup is visible
          triggers = "auto", -- automatically setup triggers
          -- triggers = {"<leader>"} -- or specify a list manually
          triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
          },
        },
      }

      local mapping_opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local vopts = {
        mode = "v", -- VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local topts = {
        mode = "t", -- VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }
      -- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
      -- see https://neovim.io/doc/user/map.html#:map-cmd

      local keymaps = {
        mode = { "n", "v" },
        ["g"] = { name = "+goto" },
        ["gz"] = { name = "+surround" },
        ["]"] = { name = "+next" },
        ["["] = { name = "+prev" },
        ["<leader><tab>"] = { name = "Tabs" },
        ["<leader>b"] = { name = "Buffer" },
        ["<leader>c"] = { name = "Code" },
        ["<leader>f"] = { name = "File / Find" },
        ["<leader>gh"] = { name = "Hunks" },
        ["<leader>q"] = { name = "Quit / Session" },
        ["<leader>s"] = { name = "Search" },
        ["<leader>u"] = { name = "Ui" },
        ["<leader>w"] = { name = "Windows" },
        ["<leader>x"] = { name = "Diagnostics / Quickfix" },
      }

      local vmappings = {
        ["/"] = {
          "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
          "Comment toggle linewise (visual)",
        },
        M = {
          name = "Magma",
          i = { " <cmd> MagmaInit <CR>", "Init Magma" },
          l = { " <cmd> MagmaEvaluateLine <CR>", "Evaluate Line" },
          c = { " <cmd> MagmaReevaluateCell <CR>", "Reevaluate Cell" },
          v = { " <cmd> MagmaEvaluateVisual <CR> ", "Evaluate Visual" },
          d = { " <cmd> MagmaDelete <CR>", "Delete" },
          o = { " <cmd> MagmaShowOutput <CR>", "Show Output" },
          r = { " <cmd> MagmaEvaluateOperator <CR> ", "Evaluate Operator" },
          x = { " <cmd> MagmaRestart! <CR>", "Restart the Current Kernel" },
          f = {
            name = "File",
            o = { " <cmd> MagmaLoad <CR> ", "Load Magma Output" },
            s = { " <cmd> MagmaSave <CR> ", "Save Magma Output" },
          },
        },
        S = {
          name = "Developer Support",
          i = {
            name = "Silicon",
            p = { "<cmd> '<,'>Silicon <CR>", "Silicon Highlight" },
          },
          w = { "<leader>saiw", "Surround Words" },
          W = { "<leader>saiW", "Surround Words" },
          s = { "<cmd> lua require('spread').out() <CR>", "Spread Out" },
          c = { "<cmd> lua require('spread').combine() <CR>", "Spread Combine" },
          b = { "<cmd> lua require('comment-box').lbox() <CR>", "Comment Box" },
          C = { "<cmd>PickColorInsert<cr>", "Pick Color" },
        },
      }

      local tmappings = {
        ["`"] = { "<cmd> exe v:count . 'ToggleTerm'<CR>", "Toggle Terminal" },
      }

      local mappings = {
        ["a"] = { "<cmd> keepjumps normal! ggVG<CR>", "Select All" },
        ["/"] = {
          function()
            require("Comment.api").toggle.linewise.current()
          end,
          "Toggle Comment Current Line",
        },
        ["C"] = { "<cmd> Bdelete <cr>", "Close buffer" },
        ["`"] = { "<cmd> exe v:count . 'ToggleTerm'<CR>", "Toggle Terminal" },

        b = {
          name = "Buffers",
          j = { "<cmd>BufferLinePick<cr>", "Jump" },
          f = { "<cmd>Telescope buffers<cr>", "Find" },
          b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
          n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
          -- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
          e = {
            "<cmd>BufferLinePickClose<cr>",
            "Pick which buffer to close",
          },
          H = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
          L = {
            "<cmd>BufferLineCloseRight<cr>",
            "Close all to the right",
          },
          h = { "<cmd> split <CR> ", "Horizontal Split" },
          v = { "<cmd> vsplit <CR> ", "V-Split" },
          D = {
            "<cmd>BufferLineSortByDirectory<cr>",
            "Sort by directory",
          },
          S = {
            "<cmd>BufferLineSortByExtension<cr>",
            "Sort by language",
          },
        },

        d = { "<cmd> ObsidianFollowLink <CR>", "Enter Obsidian Link" },

        f = {
          name = "Find",
          b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
          d = { "<cmd>Telescope diagnostics <cr>", "Diagnostics" },
          f = { "<cmd>Telescope find_files<cr>", "Find File" },
          P = { "<cmd>Telescope harpoon marks<cr>", "Search Files" },
          l = { "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Search LSP Symbols" },
          h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
          H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
          M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
          o = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
          R = { "<cmd>Telescope registers<cr>", "Registers" },
          w = { "<cmd>Telescope live_grep<cr>", "Words" },
          s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer Fuzzy" },
          k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
          C = { "<cmd>Telescope commands<cr>", "Commands" },
          p = {
            "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
            "Colorscheme with Preview",
          },
          space = { "<cmd>Telescope buffers<cr>", "Buffers" },
        },

        g = {
          name = "Git",
          g = { "<cmd>lua _lazygit_toggle()<CR>", "LazyGit" },
          j = { "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<cr>", "Next Hunk" },
          k = { "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<cr>", "Prev Hunk" },
          l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
          p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
          r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
          R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
          s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
          u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
          },
          o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
          b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
          c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
          C = {
            "<cmd>Telescope git_bcommits<cr>",
            "Checkout commit(for current file)",
          },
          d = {
            "<cmd>Gitsigns diffthis HEAD<cr>",
            "Git Diff",
          },
        },

        h = {
          name = "Harpoon",
          ["m"] = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
          ["."] = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', "Harpoon Next" },
          [","] = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', "Harpoon Prev" },
          ["l"] = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
          ["1"] = { '<cmd>lua require("harpoon.ui").nav_file(1) <CR> ', "Harpoon File 1" },
          ["2"] = { '<cmd>lua require("harpoon.ui").nav_file(2) <CR> ', "Harpoon File 2" },
          ["3"] = { '<cmd>lua require("harpoon.ui").nav_file(3) <CR> ', "Harpoon File 3" },
          ["4"] = { '<cmd>lua require("harpoon.ui").nav_file(4) <CR> ', "Harpoon File 4" },
          ["5"] = { '<cmd>lua require("harpoon.ui").nav_file(5) <CR> ', "Harpoon File 5" },
          ["6"] = { '<cmd>lua require("harpoon.ui").nav_file(6) <CR> ', "Harpoon File 6" },
        },

        l = {
          name = "LSP",
          a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
          e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
          d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
          i = { "<cmd>LspInfo<cr>", "Info" },
          I = { "<cmd>Mason<cr>", "Mason Info" },
          j = {
            vim.diagnostic.goto_next,
            "Next Diagnostic",
          },
          k = {
            vim.diagnostic.goto_prev,
            "Prev Diagnostic",
          },
          l = { vim.lsp.codelens.run, "CodeLens Action" },
          n = {
            name = "Null-LS",
            i = { " <cmd> NullLsInfo <CR>", "Info" },
            I = { " <cmd> NullLsInstall <CR>", "Install" },
            l = { " <cmd> NullLsLog <CR>", "Log" },
            u = { " <cmd> NullLsUninstall <CR>", "Uninstall" },
          },
          o = { "<cmd> SymbolsOutline <CR> ", "Symbols Outline" },
          q = { vim.diagnostic.setloclist, "Quickfix" },
          r = { "<cmd> LspRestart <CR> ", "Restart LSP" },
          s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
          S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
          },
          t = {
            name = "NeoTest",
            a = { '<cmd> lua require("neotest").run.attach() <CR> ', "Toggle NeoTest" },
            t = { '<cmd> lua require("neotest").summary.toggle() <CR> ', "Toggle NeoTest" },
            r = { '<cmd> lua require("neotest").run.run() <CR>', "Start Nearest Test" },
            R = { '<cmd> lua require("neotest").run.stop() <CR>', "Stop Nearest Test" },
          },
          w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
        },

        M = {
          name = "Magma",
          i = { " <cmd> MagmaInit <CR>", "Init Magma" },
          l = { " <cmd> MagmaEvaluateLine <CR>", "Evaluate Line" },
          c = { " <cmd> MagmaReevaluateCell <CR>", "Reevaluate Cell" },
          v = { " <cmd> MagmaEvaluateVisual <CR> ", "Evaluate Visual" },
          d = { " <cmd> MagmaDelete <CR>", "Delete" },
          o = { " <cmd> MagmaShowOutput <CR>", "Show Output" },
          r = { " <cmd> MagmaEvaluateOperator <CR> ", "Evaluate Operator" },
          x = { " <cmd> MagmaRestart! <CR>", "Restart the Current Kernel" },
          f = {
            name = "File",
            o = { " <cmd> MagmaLoad <CR> ", "Load Magma Output" },
            s = { " <cmd> MagmaSave <CR> ", "Save Magma Output" },
          },
        },

        n = {
          name = "NotAnotherNvimConfig",
          q = { "<cmd> qa! <CR> ", "Quit All No Save" },
          w = {
            name = "Write",
            q = { "<cmd> wqall! <cr> ", "Write All then Quit All" },
            w = { "<cmd> wall! <cr> ", "Write All" },
          },
          k = { "<cmd>Telescope keymaps<cr>", "View Keymappings" },
          n = { "<cmd>Telescope notify<cr>", "View Notifications" },
          h = { "<cmd>nohlsearch<CR>", "No Highlight" },
          p = {
            name = "Pomodoro",
            s = { "<cmd>PomodoroStart<CR>", "Pomodoro Start" },
            S = { "<cmd>PomodoroStatus<CR>", "Pomodoro Status" },
            q = { "<cmd>PomodoroStop<CR>", "Pomodoro Stop" },
          },
        },

        o = {
          name = "NeOrg",
          g = {
            name = "Get Things Done",
            v = { "<cmd>Neorg gtd views<CR> ", "Views" },
            c = { "<cmd>Neorg gtd capture<CR> ", "Capture" },
          },
        },

        O = {
          name = "Obsidian",
          b = { "<cmd> ObsidianBacklinks <CR>", "Backlinks Location List" },
          f = { "<cmd> ObsidianFollowLink <CR>", "Enter Obsidian Link" },
          l = { "<cmd> ObsidianLink <CR>", "Obsidian Link" },
          L = { "<cmd> ObsidianLink <CR>", "Obsidian Link New" },
          n = { "<cmd> ObsidianNew <CR>", "New Obsidian Note" },
          o = { "<cmd> ObsidianQuickSwitch <CR>", "Open Obsidian File" },
          s = { "<cmd> ObsidianSearch <CR>", "Search Obsidian Vault" },
          t = { "<cmd> ObsidianToday <CR>", "Create Daily Note" },
          y = { "<cmd> ObsidianYesterday <CR>", "Open Yesterdays Note" },
        },

        p = {
          name = "Plugins",
          c = { "<cmd>:Lazy clean<cr>", "Clean" },
          i = { "<cmd>:Lazy install<cr>", "Install" },
          s = { "<cmd>:Lazy sync<cr>", "Sync" },
          S = { "<cmd>PackerStatus<cr>", "Status" },
          u = { "<cmd>:Lazy update<cr>", "Update" },
          p = { "<cmd>:Lazy profile<cr>", "Profile" },
        },

        S = {
          name = "Developer Support",
          i = {
            name = "Silicon",
            s = { "<cmd>Silicon <CR>", "Silicon Buffer Picture" },
            p = { "<cmd> '<,'>Silicon <CR>", "Silicon Highlight" },
          },
          w = { "<leader>saiw", "Surround Words" },
          W = { "<leader>saiW", "Surround Words" },
          s = { "<cmd> lua require('splitjoin').split() <CR>", "Split Object" },
          c = { "<cmd> lua require('splitjoin').join() <CR>", "Combine Object" },
          b = { "<cmd> lua require('comment-box').lbox() <CR>", "Comment Box" },
          C = { "<cmd>PickColor<cr>", "Pick Color" },
        },

        T = {
          name = "Treesitter",
          i = { ":TSConfigInfo<cr>", "Info" },
          h = { "<cmd> TSHighlightCapturesUnderCursor <CR>", "Show Highlights" },
          p = { "<cmd> TSPlaygroundToggle <CR>", "Toggle Playground" },
        },

        t = {
          name = "Trouble",
          t = { "<cmd> TroubleToggle <CR> ", "Toggle Trouble" },
          T = { "<cmd> TodoTrouble <CR> ", "Trouble Todos" },
          w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
          d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
          l = { "<cmd>TroubleToggle loclist<cr>", "Quickfix" },
          q = { "<cmd>TroubleToggle quickfix<cr>", "LocList" },
          r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
        },

        z = {
          name = "Dont press this.",
          v = {
            name = "I swear some people never listen....",
            t = {
              name = "Okay... Stop pressing these.",
              q = {
                name = "Alright. I will tell you.",
                d = {
                  name = "Only if you choose correctly...",
                  c = {},
                },
              },
            },
          },
        },
      }

      if Util.has("noice.nvim") then
        keymaps["<leader>sn"] = { name = "+noice" }
      end

      local which_key = require("which-key")

      which_key.register(mappings, mapping_opts)
      which_key.register(vmappings, vopts)
      which_key.register(tmappings, topts)
      which_key.register(keymaps)
      which_key.setup(options)
    end,
  },
}

return {
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },

      ---@param colors ColorScheme
      on_colors = function(colors)
        colors.fg = "#4AB5B3"
      end,
      ---@param highlights Highlights
      ---@param colors ColorScheme f
      on_highlights = function(highlights, colors)
        highlights["@variable"] = {
          fg = "#c678dd",
        }
        highlights["FlashLabel"] = {
          fg = "#050505",
          bg = "#86e1fc",
        }
        highlights["FlashMatch"] = {
          fg = "#ededef",
          bg = "#394b70",
        }
        highlights["LineNr"] = {
          fg = "#3D8EA1",
        }
      end,
    },
  },
}

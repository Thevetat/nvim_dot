return {
  {
    "epwalsh/obsidian.nvim",
    event = "VeryLazy",
    opts = {
      dir = "~/Git/Obsidian/thinned-garden/",
      note_id_func = function(title)
        return title
      end,
      notes_subdir = "Inbox",
      daily_notes = {
        folder = "dailies",
      },
      completion = {
        nvim_cmp = true,
      },
      disable_frontmatter = true,
    },
  },
}

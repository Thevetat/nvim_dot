return {
  {
    "jackMort/ChatGPT.nvim",
    event = "BufReadPre",
    opts = {
      openai_params = {
        model = "text-davinci-003",
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 300,
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      openai_edit_params = {
        model = "code-davinci-edit-001",
        temperature = 0,
        top_p = 1,
        n = 1,
      },
      keymaps = {
        close = { "<C-c>", "<Esc>" },
        yank_last = "<C-y>",
        scroll_up = "<C-k>",
        scroll_down = "<C-j>",
        toggle_settings = "<C-o>",
        new_session = "<C-n>",
        cycle_windows = "<C-l>",
      },
    },
  },
}

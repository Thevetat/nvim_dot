local g = vim.g

local options = {
  -- Behavior --
  timeoutlen = 500,
  updatetime = 250,
  fileencoding = "utf-8", -- the encoding written to a file
  hlsearch = false, -- highlight all matches on previous search pattern
  incsearch = true,
  scrolloff = 8, -- is one of my fav
  sidescrolloff = 8,
  nu = true,
  clipboard = "unnamedplus",
  ignorecase = true,
  smartcase = true,
  mouse = "a",
  splitbelow = true,
  splitright = true,

  -- Indenting --
  expandtab = true,
  shiftwidth = 2,
  smartindent = true,
  tabstop = 2,
  softtabstop = 2,

  -- Visual --
  number = true, -- TODO: Test if number is needed
  relativenumber = true, -- set relative numbered lines
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  pumheight = 10, -- pop up menu height
  numberwidth = 4, -- set number column width to 2 {default 4}
  -- statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s",
  wrap = false,
  colorcolumn = "120",
  ruler = true,
  laststatus = 3, -- global statusline
  showmode = false,
  title = true,
  cursorline = true,
  signcolumn = "yes",
  termguicolors = true,
  fillchars = { eob = " " },
  conceallevel = 0, -- so that `` is visible in markdown files
  -- Folding
  foldlevel = 99,
  foldmethod = "expr",
  foldexpr = "ntreesitter#foldexpr()",
  foldenable = true,

  -- Files --
  swapfile = false, -- creates a swapfile
  backup = false, -- creates a backup file
  undofile = true, -- enable persistent undo
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  undodir = os.getenv("HOME") .. "/.local/share/undodir",
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

g.transparency = true
vim.cmd([[set pumblend=0]])

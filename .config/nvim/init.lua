-- Added configuration:
-- Theme: Catppuccin
-- Telescope: fuzzy finder
-- Treesitter: creates an abstract tree of the code that makes it easy to highlight it (among other things)
-- Neotree: tree-structured project on the side
-- lualine: status bar
-- lsp
-- none ls: Formatting and linting
-- luasnip: autocompletions

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.clipboard = 'unnamedplus'
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.conceallevel = 2

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set('n', "<leader>v", ':wincmd v<CR>')
vim.keymap.set('n', "<leader>s", ':wincmd s<CR>')
vim.keymap.set('n', "<leader>q", ':wincmd q<CR>')

vim.keymap.set('n', "<leader>h", ':nohlsearch <CR>') -- Quit highlighting

-- jj as escape key
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })

vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
]])

require("config.lazy")



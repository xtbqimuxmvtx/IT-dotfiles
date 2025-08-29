-- misc vim.o
vim.o.showmode = true
-- TODO:
vim.o.clipboard = "unnamedplus"
vim.o.updatetime = 25
vim.o.backup = true

-- Swap k & j at the keymap level (handles every lower-case instance; including some of :wincmd )
vim.o.langmap = "jk,kj"
-- vim.keymap.set('o', 'k', 'j', { noremap = true})
-- vim.keymap.set('o', 'j', 'k', { noremap = true})
-- vim.keymap.set({ 'o', 'n', 'x' }, 'k', 'j', { noremap = true})
-- vim.keymap.set({ 'o', 'n', 'x' }, 'j', 'k', { noremap = true})
-- :wincmd necessary for when the ctrl key is held (parses as capital J;K)
vim.g.mapleader = ' '
vim.keymap.set({ 'n', 'x' }, '<C-W>j', ':wincmd k<CR>')
vim.keymap.set({ 'n', 'x' }, '<C-W>k', ':wincmd j<CR>')
vim.keymap.set({ 'n', 'x' }, '<C-W>J', ':wincmd K<CR>')
vim.keymap.set({ 'n', 'x' }, '<C-W>K', ':wincmd J<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>p', ':write<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>o', ':update<CR>:source<CR>')

-- other vim.o

vim.o.relativenumber = true
vim.o.number = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.wrap = false

-- pane & search
vim.o.scrolloff = 4
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.hlsearch = false
vim.o.signcolumn = yes

-- backups
vim.opt.backupdir = "/tmp/nvim-backup"

-- specific use
-- html 'matchit' plugin for tags:
vim.g.loaded_matchit = 1

-- other binds:
vim.keymap.set({ 'n', 'x' }, '<leader>;', ':q<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>x', ':q<CR>')
vim.keymap.set({ 'n', 'x' }, '<leader>f', ':s///<Left><Left>', { silent = false })
-- Emacs-style editing on the command-line (readline)
vim.api.nvim_set_keymap("c", "<C-A>", "<Home>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("c", "<C-B>", "<Left>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("c", "<C-D>", "<Del>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("c", "<C-E>", "<End>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("c", "<C-F>", "<Right>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("c", "<C-N>", "<Down>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("c", "<C-P>", "<Up>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("c", "<M-B>", "<S-Left>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("c", "<M-F>", "<S-Right>", { noremap = true, silent = false })
-- back one word (key sequence)
vim.api.nvim_set_keymap("c", "<Esc><C-B>", "<S-Left>", { noremap = true, silent = false })
-- forward one word (key sequence)
vim.api.nvim_set_keymap("c", "<Esc><C-F>", "<S-Right>", { noremap = true, silent = false })

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
                            group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
                            callback = function()
                            vim.highlight.on_yank()
                            end,
})

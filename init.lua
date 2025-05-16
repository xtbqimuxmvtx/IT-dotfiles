vim.api.nvim_set_var('q', 'macro contents')
-- Swap j and k in normal and visual mode
vim.keymap.set({'n', 'v'}, 'j', 'k', { noremap = true })
vim.keymap.set({'n', 'v'}, 'k', 'j', { noremap = true })
-- Swap gj and gk in normal and visual mode
vim.keymap.set({'n', 'v'}, 'gj', 'gk', { noremap = true })
vim.keymap.set({'n', 'v'}, 'gk', 'gj', { noremap = true })

vim.o.relativenumber = true
vim.o.number = true
vim.o.mouse = 'a'
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 14
vim.o.showmode = true
vim.schedule(function()
vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
                            group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
                            callback = function()
                            vim.highlight.on_yank()
                            end,
})

-- Setup lazy.nvim path
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
    end
    end

    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup({
      'NMAC427/guess-indent.nvim',
      {
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        dependencies = {
          'nvim-lua/plenary.nvim',
          {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
            return vim.fn.executable('make') == 1
            end,
          },
          { 'nvim-telescope/telescope-ui-select.nvim' },
          { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
        },
        config = function()
        require('telescope').setup({
          extensions = {
            ['ui-select'] = {
              require('telescope.themes').get_dropdown(),
            },
          },
        })
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({ winblend = 10, previewer = false }))
        end, { desc = '[/] Fuzzily search in current buffer' })
        vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep({ grep_open_files = true, prompt_title = 'Live Grep in Open Files' })
        end, { desc = '[S]earch [/] in Open Files' })
        vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end, { desc = '[S]earch [N]eovim files' })
        end,
      },

      -- Other plugins like LSP, colorschemes, etc., go here...

    })

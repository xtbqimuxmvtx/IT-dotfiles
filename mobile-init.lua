-- vim.api.nvim_set_var('q', 'macro contents')
-- -- Swap j and k in normal and visual mode
-- vim.keymap.set({'n', 'v'}, 'j', 'k', { noremap = true })
-- vim.keymap.set({'n', 'v'}, 'k', 'j', { noremap = true })
-- -- Swap gj and gk in normal and visual mode
-- vim.keymap.set({'n', 'v'}, 'gj', 'gk', { noremap = true })
-- vim.keymap.set({'n', 'v'}, 'gk', 'gj', { noremap = true })
--vim.api.nvim_del_keymap('i', '<C-t>')  -- In insert mode
--vim.api.nvim_set_keymap('i', '<C-t>', '<C-v>u9', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('i', '<C-t>', '<C-v>u9', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Space>', '<C-v>u9 <BS>', { noremap = true, silent = true })
vim.o.relativenumber = true
vim.o.number = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.mouse = 'a'
-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 14
vim.o.showmode = true
vim.schedule(function()
-- vim.o.clipboard = 'unnamedplus,termux'
vim.o.clipboard = 'unnamedplus'
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 25

vim.cmd.colorscheme = desert
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
                            group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
                            callback = function()
                            vim.highlight.on_yank()
                            end,
})
vim.g.vimwiki_path = '~/vimwiki/'
vim.g.vimwiki_syntax = 'markdown'
vim.g.vimwiki_ext = 'md'

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
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        styles = {
          comments = { italic = false }, -- Disable italics in comments
        },
      }
  end,
},
--       {
--         'catppuccin/nvim',
--       name = "catppuccin",
--       priority = 1000
--       },
      'NMAC427/guess-indent.nvim',
      {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
      opts = {},
        -- Optional dependencies
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
--	priority = 1000,
      },
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
      },    --=+$%#%$+= End Telescope.nvim configuration ###############
    'vimwiki/vimwiki',
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },
--  { -- Autocompletion
--    'saghen/blink.cmp',
--    event = 'VimEnter',
--    version = '1.*',
--    dependencies = {
--      -- Snippet Engine
--      {
--        'L3MON4D3/LuaSnip',
--        version = '2.*',
--        build = (function()
--          -- Build Step is needed for regex support in snippets.
--          -- This step is not supported in many windows environments.
--          -- Remove the below condition to re-enable on windows.
--          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
--            return
--          end
--          return 'make install_jsregexp'
--        end)(),
--        dependencies = {
--          -- `friendly-snippets` contains a variety of premade snippets.
--          --    See the README about individual language/framework/plugin snippets:
--          --    https://github.com/rafamadriz/friendly-snippets
--          -- {
--          --   'rafamadriz/friendly-snippets',
--          --   config = function()
--          --     require('luasnip.loaders.from_vscode').lazy_load()
--          --   end,
--          -- },
--        },
--        opts = {},
--      },
--      'folke/lazydev.nvim',
--    },
--    --- @module 'blink.cmp'
--    --- @type blink.cmp.Config
--    opts = {
--      keymap = {
--        -- 'default' (recommended) for mappings similar to built-in completions
--        --   <c-y> to accept ([y]es) the completion.
--        --    This will auto-import if your LSP supports it.
--        --    This will expand snippets if the LSP sent a snippet.
--        -- 'super-tab' for tab to accept
--        -- 'enter' for enter to accept
--        -- 'none' for no mappings
--        --
--        -- For an understanding of why the 'default' preset is recommended,
--        -- you will need to read `:help ins-completion`
--        --
--        -- No, but seriously. Please read `:help ins-completion`, it is really good!
--        --
--        -- All presets have the following mappings:
--        -- <tab>/<s-tab>: move to right/left of your snippet expansion
--        -- <c-space>: Open menu or open docs if already open
--        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
--        -- <c-e>: Hide menu
--        -- <c-k>: Toggle signature help
--        --
--        -- See :h blink-cmp-config-keymap for defining your own keymap
--        preset = 'default',
--
--        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
--        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
--      },
--
--      appearance = {
--        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
--        -- Adjusts spacing to ensure icons are aligned
--        nerd_font_variant = 'mono',
--      },
--
--      completion = {
--        -- By default, you may press `<c-space>` to show the documentation.
--        -- Optionally, set `auto_show = true` to show the documentation after a delay.
--        documentation = { auto_show = false, auto_show_delay_ms = 500 },
--      },
--
--      sources = {
--        default = { 'lsp', 'path', 'snippets', 'lazydev' },
--        providers = {
--          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
--        },
--      },
--
--      snippets = { preset = 'luasnip' },
--
--      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
--      -- which automatically downloads a prebuilt binary when enabled.
--      --
--      -- By default, we use the Lua implementation instead, but you may enable
--      -- the rust implementation via `'prefer_rust_with_warning'`
--      --
--      -- See :h blink-cmp-config-fuzzy for more information
--      fuzzy = { implementation = 'lua' },
--
--      -- Shows a signature help window while you type arguments for a function
--      signature = { enabled = true },
--    },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
--  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
    require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.debug',
    require 'kickstart.plugins.indent_line',
	  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps
})
  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
      -- Other plugins like LSP, colorschemes, etc., go here...
require("oil").setup({
  -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
  -- Set to false if you want some other plugin (e.g. netrw) to open when you edit directories.
  default_file_explorer = true,
  -- Id is automatically added at the beginning, and name at the end
  -- See :help oil-columns
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    bufhidden = "hide",
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = false,
    foldcolumn = "0",
    spell = false,
    list = false,
    conceallevel = 3,
    concealcursor = "nvic",
  },
  -- Send deleted files to the trash instead of permanently deleting them (:help oil-trash)
  delete_to_trash = false,
  -- Skip the confirmation popup for simple operations (:help oil.skip_confirm_for_simple_edits)
  skip_confirm_for_simple_edits = false,
  -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
  -- (:help prompt_save_on_select_new_entry)
  prompt_save_on_select_new_entry = true,
  -- Oil will automatically delete hidden buffers after this delay
  -- You can set the delay to false to disable cleanup entirely
  -- Note that the cleanup process only starts when none of the oil buffers are currently displayed
  cleanup_delay_ms = 2000,
  lsp_file_methods = {
    -- Enable or disable LSP file operations
    enabled = true,
    -- Time to wait for LSP file operations to complete before skipping
    timeout_ms = 1000,
    -- Set to true to autosave buffers that are updated with LSP willRenameFiles
    -- Set to "unmodified" to only save unmodified buffers
    autosave_changes = false,
  },
  -- Constrain the cursor to the editable parts of the oil buffer
  -- Set to `false` to disable, or "name" to keep it on the file names
  constrain_cursor = "editable",
  -- Set to true to watch the filesystem for changes and reload oil
  watch_for_changes = false,
  -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
  -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
  -- Additionally, if it is a string that matches "actions.<name>",
  -- it will use the mapping at require("oil.actions").<name>
  -- Set to `false` to remove a keymap
  -- See :help oil-actions for a list of all available actions
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true } },
    ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
    ["<C-t>"] = { "actions.select", opts = { tab = true } },
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = { "actions.close", mode = "n" },
    ["<C-l>"] = "actions.refresh",
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["gs"] = { "actions.change_sort", mode = "n" },
    ["gx"] = "actions.open_external",
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = true,
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
    -- This function defines what is considered a "hidden" file
    is_hidden_file = function(name, bufnr)
      local m = name:match("^%.")
      return m ~= nil
    end,
    -- This function defines what will never be shown, even when `show_hidden` is set
    is_always_hidden = function(name, bufnr)
      return false
    end,
    -- Sort file names with numbers in a more intuitive order for humans.
    -- Can be "fast", true, or false. "fast" will turn it off for large directories.
    natural_order = "fast",
    -- Sort file and directory names case insensitive
    case_insensitive = false,
    sort = {
      -- sort order can be "asc" or "desc"
      -- see :help oil-columns to see which columns are sortable
      { "type", "asc" },
      { "name", "asc" },
    },
    -- Customize the highlight group for the file name
    highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
      return nil
    end,
  },
  -- Extra arguments to pass to SCP when moving/copying files over SSH
  extra_scp_args = {},
  -- EXPERIMENTAL support for performing file operations with git
  git = {
    -- Return true to automatically git add/mv/rm files
    add = function(path)
      return false
    end,
    mv = function(src_path, dest_path)
      return false
    end,
    rm = function(path)
      return false
    end,
  },
  -- Configuration for the floating window in oil.open_float
  float = {
    -- Padding around the floating window
    padding = 2,
    -- max_width and max_height can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    max_width = 0,
    max_height = 0,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
    -- optionally override the oil buffers window title with custom function: fun(winid: integer): string
    get_win_title = nil,
    -- preview_split: Split direction: "auto", "left", "right", "above", "below".
    preview_split = "auto",
    -- This is the config that will be passed to nvim_open_win.
    -- Change values here to customize the layout
    override = function(conf)
      return conf
    end,
  },
  -- Configuration for the file preview window
  preview_win = {
    -- Whether the preview window is automatically updated when the cursor is moved
    update_on_cursor_moved = true,
    -- How to open the preview window "load"|"scratch"|"fast_scratch"
    preview_method = "fast_scratch",
    -- A function that returns true to disable preview on a file e.g. to avoid lag
    disable_preview = function(filename)
      return false
    end,
    -- Window-local options to use for preview window buffers
    win_options = {},
  },
  -- Configuration for the floating action confirmation window
  confirmation = {
    -- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_width and max_width can be a single value or a list of mixed integer/float types.
    -- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
    max_width = 0.9,
    -- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
    min_width = { 40, 0.4 },
    -- optionally define an integer/float for the exact width of the preview window
    width = nil,
    -- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
    -- min_height and max_height can be a single value or a list of mixed integer/float types.
    -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
    max_height = 0.9,
    -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
    min_height = { 5, 0.1 },
    -- optionally define an integer/float for the exact height of the preview window
    height = nil,
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating progress window
  progress = {
    max_width = 0.9,
    min_width = { 40, 0.4 },
    width = nil,
    max_height = { 10, 0.9 },
    min_height = { 5, 0.1 },
    height = nil,
    border = "rounded",
    minimized_border = "none",
    win_options = {
      winblend = 0,
    },
  },
  -- Configuration for the floating SSH window
  ssh = {
    border = "rounded",
  },
  -- Configuration for the floating keymaps help window
  keymaps_help = {
    border = "rounded",
  },
})
require("nvim-web-devicons").set_default_icon('', '#6d8086', 65)
-- require("catppuccin").setup({
--     flavour = "frappe", -- latte, frappe, auto, macchiato, mocha
--     background = { -- :h background
--         light = "latte",
--        dark = "mocha",
--    },
-- })
-- vim.g.vimwiki_list = {
--     {
--         path = '~/vimwiki/',
--         syntax = 'markdown',
--         ext = 'md'
--     }
-- }

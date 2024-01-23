-- vim-lazy - plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
    { "fatih/vim-go" },
    { "knubie/vim-kitty-navigator" },
    { "github/copilot.vim" },
    { "p00f/clangd_extensions.nvim" },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    { "hrsh7th/cmp-cmdline" },
    { "itchyny/lightline.vim" },
    { "junegunn/fzf" },
    { "junegunn/fzf.vim" },
    { "preservim/tagbar" },
})

vim.cmd [[let g:lightline = { 'colorscheme': 'moonfly' }]]
vim.cmd [[colorscheme moonfly]]

-- vim options
vim.cmd [[set splitbelow]]
vim.cmd [[set splitright]]
vim.cmd [[set expandtab]]
vim.cmd [[set shiftwidth=4]]
vim.cmd [[set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<]]

-- shortcuts
vim.api.nvim_set_keymap('n', '<F3>', ':set wrap! <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F6>', ':set hlsearch! <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F8>', ':execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "") <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-P>', ':Files <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-g>', ':Rg <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-t>', ':tabn <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-t>', ':tabp <CR>', { noremap = true, silent = true })
-- move by visual line
vim.cmd [[nnoremap <expr> j v:count == 0 ? 'gj' : "\<Esc>".v:count.'j']]
vim.cmd [[nnoremap <expr> k v:count == 0 ? 'gk' : "\<Esc>".v:count.'k']]

-- line number stuff
vim.cmd [[set number]]
local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave' }, {
  pattern = '*',
  group = numbertoggle,
  command = 'set relativenumber',
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter' }, {
  pattern = '*',
  group = numbertoggle,
  command = 'set norelativenumber number',
})

-- fzf
--vim.cmd [[set rtp+=~/.fzf]]
--vim.cmd [[rtp+=~/fzf]]
vim.cmd [[let g:fzf_layout = {'down' : '~20%'}]]

-- vim-kitty-navigator
if os.getenv("TERM") == "xterm-kitty" then
    vim.g.kitty_navigator_no_mappings = 1
    vim.g.tmux_navigator_no_mappings = 1

    vim.api.nvim_set_keymap('n', 'C-h', ':KittyNavigateLeft <CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'C-j', ':KittyNavigateDown <CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'C-k', ':KittyNavigateUp <CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'C-l', ':KittyNavigateRight <CR>', { noremap = true, silent = true })
end

-- copilot
vim.g.copilot_enabled = 'false'
vim.api.nvim_set_keymap('n', '<leader>cp', ':Copilot enable <CR>', {noremap = true, silent = true })

-- vim-go
vim.g.go_fmt_command = 'goimports'
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_operators = 1
vim.g.go_fmt_autosave = 1
vim.g.go_def_mapping_enabled = 0

-- completion
---- nvim-cmp
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- `:` cmdline setup
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' }
      }
    }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

---- language servers
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {}
lspconfig.gopls.setup {}

-- run last
vim.cmd [[highlight LineNr guibg=black]]

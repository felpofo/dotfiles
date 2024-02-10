local cmd = vim.cmd
local options = { silent = true, noremap = true }

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or options)
end

local function nmap(lhs, rhs) map('n', lhs, rhs) end
local function imap(lhs, rhs) map('i', lhs, rhs) end
local function vmap(lhs, rhs) map('x', lhs, rhs) end
local function tmap(lhs, rhs) map('t', lhs, rhs) end

-- Normal mode
map('i', 'jk', '<ESC>', { nowait = true })
map('t', 'jk', '<C-\\><C-n>', { nowait = true })
map('t', '<ESC>', '<C-\\><C-n>', { nowait = true })
vmap('<BS>', '"_x')

-- Remove search highlights
nmap('<ESC>', cmd.noh)

-- Close buffer
nmap('<C-q>', cmd.BufferClose)
imap('<C-q>', cmd.BufferClose)
vmap('<C-q>', cmd.BufferClose)

-- Switch buffer
nmap('<C-n>', cmd.BufferPrevious)
nmap('<C-m>', cmd.BufferNext)

-- Save buffer
nmap('<C-s>', cmd.w)
imap('<C-s>', cmd.w)
vmap('<C-s>', cmd.w)

-- Movement
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

nmap('<C-h>', '<C-o><C-w>h')
nmap('<C-j>', '<C-o><C-w>j')
nmap('<C-k>', '<C-o><C-w>k')
nmap('<C-l>', '<C-o><C-w>l')

tmap('<C-h>', '<C-w>h')
tmap('<C-j>', '<C-w>j')
tmap('<C-k>', '<C-w>k')
tmap('<C-l>', '<C-w>l')

-- Resize
nmap('<A-h>', '<C-w><')
nmap('<A-j>', '<C-w>-')
nmap('<A-k>', '<C-w>+')
nmap('<A-l>', '<C-w>>')

nmap('<A-h>', '<C-o><C-w><')
nmap('<A-j>', '<C-o><C-w>-')
nmap('<A-k>', '<C-o><C-w>+')
nmap('<A-l>', '<C-o><C-w>>')

tmap('<A-h>', '<C-w><')
tmap('<A-j>', '<C-w>-')
tmap('<A-k>', '<C-w>+')
tmap('<A-l>', '<C-w>>')

-- Split windows
nmap('<leader>sd', cmd.vsplit)
nmap('<leader>sv', cmd.split)

--[[ Files ]]
local telescope = require 'telescope.builtin'
local function find_hidden_files()
  telescope.find_files { hidden = true }
end

-- Telescope
nmap('<leader>ff', telescope.find_files)
nmap('<leader>fa', find_hidden_files)
nmap('<leader>fg', telescope.live_grep)
nmap('<leader>fb', telescope.buffers)

-- File tree
nmap('<C-e>', cmd.NvimTreeToggle)
nmap('<leader>fe', cmd.NvimTreeFocus)

-- Increment/Decrement
nmap('-', '<C-x>')
nmap('+', '<C-a>')

-- Indent/Unindent
nmap('>', '>0')
nmap('<', '<0')
vmap('>', '>gv')
vmap('<', '<gv')

-- Select all
nmap('<C-a>', 'gg<S-v>G')

-- Move selection up/down
vmap('<S-j>', ":m '>+1 <CR>gv=gv")
vmap('<S-k>', ":m '<-2 <CR>gv=gv")

-- Open things
nmap('<leader>ol', cmd.Lazy)         -- open lazy
nmap('<leader>om', cmd.Mason)        -- open mason
nmap('<leader>os', cmd.LspInfo)      -- open syntax
nmap('<leader>ot', cmd.TSModuleInfo) -- open treesitter

-- Surround selection with quotes
vmap('"', '<ESC>`>a\"<ESC>`<i\"<ESC>gv2l')
vmap("'", '<ESC>`>a\'<ESC>`<i\'<ESC>gv2l')
vmap('`', '<ESC>`>a`<ESC>`<i`<ESC>gv2l')

-- p doesn't copy after replace (stolen from nvchad)
vmap('p', 'p:let @+=@0<CR>:let @"=@0<CR>')

-- Autocmds
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Mappings',
  callback = function()
    local lsp = vim.lsp
    options.buffer = true

    nmap('K', lsp.buf.hover)
    nmap('<F2>', lsp.buf.rename)

    nmap('<leader>gd', lsp.buf.definition)
    nmap('<leader>gD', lsp.buf.declaration)
    nmap('<leader>gi', lsp.buf.implementation)
    nmap('<leader>go', lsp.buf.type_definition)
    nmap('<leader>gr', lsp.buf.references)
    nmap('<leader>gs', lsp.buf.signature_help)
    nmap('<leader>gl', vim.diagnostic.open_float)
  end
})

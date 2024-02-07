local options = { silent = true, noremap = true }

local function map(mode, lhs, rhs)
  vim.keymap.set(mode, lhs, rhs, options)
end

local function nmap(lhs, rhs) map('n', lhs, rhs) end
local function imap(lhs, rhs) map('i', lhs, rhs) end
local function vmap(lhs, rhs) map('x', lhs, rhs) end
local function tmap(lhs, rhs) map('t', lhs, rhs) end

-- Normal mode
imap('jk', '<ESC>')
tmap('jk', '<C-\\><C-n>')

-- Delete without copy
vmap('<BS>', '"_x')

-- Cancel search highlights
nmap('<ESC>', ':nohlsearch <Bar> :echo <CR>')

-- Close buffer
nmap('<C-q>', vim.cmd.BufferClose)
imap('<C-q>', vim.cmd.BufferClose)
vmap('<C-q>', vim.cmd.BufferClose)

-- Switch buffer
nmap('<C-n>', vim.cmd.BufferPrevious)
nmap('<C-m>', vim.cmd.BufferNext)

-- Save buffer
nmap('<C-s>', vim.cmd.w)
imap('<C-s>', vim.cmd.w)
vmap('<C-s>', vim.cmd.w)

-- Files
nmap('<C-e>', vim.cmd.Lex) -- TODO  open nvim-tree

-- Movement
nmap('<C-h>', '<C-w>h')
nmap('<C-j>', '<C-w>j')
nmap('<C-k>', '<C-w>k')
nmap('<C-l>', '<C-w>l')

tmap('<C-h>', '<C-w>h')
tmap('<C-j>', '<C-w>j')
tmap('<C-k>', '<C-w>k')
tmap('<C-l>', '<C-w>l')

-- Resize
nmap('<A-h>', '<C-w><')
nmap('<A-j>', '<C-w>-')
nmap('<A-k>', '<C-w>+')
nmap('<A-l>', '<C-w>>')

tmap('<A-h>', '<C-w><')
tmap('<A-j>', '<C-w>-')
tmap('<A-k>', '<C-w>+')
tmap('<A-l>', '<C-w>>')

-- Split windows
nmap('<leader>sd', vim.cmd.vsplit)
nmap('<leader>sv', vim.cmd.split)

local telescope = require 'telescope.builtin'
local function find_hidden_files()
  telescope.find_files { hidden = true }
end

nmap('<leader>ff', telescope.find_files)
nmap('<leader>fa', find_hidden_files)
nmap('<leader>fg', telescope.live_grep)
nmap('<leader>fb', telescope.buffers)
-- TODO  nvim tree toggle
--nmap('<leader>fe', )

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

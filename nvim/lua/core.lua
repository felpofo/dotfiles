local opt = vim.opt

vim.g.mapleader = ','
-- config mostly stolen from nvchad and lazyvim - too lazy to read all options one by one

-- editor
opt.showmode = false -- we have a status line
opt.cursorline = true -- hover cursor line
opt.clipboard = 'unnamedplus' -- sync clipboard with system

opt.mouse = 'a' -- enable mouse

opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- don't ignore case if search has an upper one

opt.termguicolors = true -- true color
opt.whichwrap:append '<>[]hl' -- eol wrap

opt.completeopt = 'menu,menuone,noselect' -- i'll never know
opt.pumheight = 8 -- popup height size (completions, etc.)

opt.number = true -- show numbers on the line's left
  opt.relativenumber = true
opt.numberwidth = 2
opt.signcolumn = 'yes' -- always show the 'warns' column

opt.scrolloff = 6 -- min lines around cursor
  opt.sidescrolloff = 12 -- min chars around cursor

opt.ruler = false -- default nvim location info

opt.splitbelow = true -- when splitting, focus that window
opt.splitright = true -- same

opt.virtualedit = 'block' -- allow cursor to move where there's no text in visual mode
opt.wildmode = 'longest:full,full'

opt.foldlevel = 99

-- tabs and spaces
opt.shiftwidth = 2 -- indent size (2 spaces)
  opt.shiftround = true -- round indent (?)
opt.expandtab = true -- tabs become spaces
  opt.smarttab = true -- tabs inherit spaces sizing
opt.tabstop = 2 -- just to be sure
  opt.softtabstop = 2

-- text
opt.wrap = false -- line wrap
  opt.linebreak = true -- wrap at whitespace
opt.spell = false -- spell check
opt.list = true -- show invisible characters
  opt.listchars = {
    tab = '󰌒 ',
    space = '󰧟',
  }
  opt.fillchars = {
    foldopen = '',
    foldclose = '',
    -- fold = '⸱',
    fold = ' ',
    foldsep = ' ',
    diff = '╱',
    eob = ' ',
  }

-- buffer
opt.confirm = true -- confirm modified buffers
opt.backup = false -- backup after overwriting a file
opt.undofile = true
  opt.undolevels = 1024

-- keybinds
opt.timeout = true
opt.timeoutlen = 500

local disable = {
  'netrw'
}

for _, module in ipairs(disable) do
  vim.g['loaded_' .. module] = 1
  vim.g['loaded_' .. module .. 'Plugin'] = 1
end

local editorconfig = require 'editorconfig'

local properties = {
  language = function(buffer, value)
    vim.bo[buffer].filetype = value
  end
}

for property, executor in pairs(properties) do
  editorconfig.properties[property] = executor
end

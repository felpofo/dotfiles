function filename()
  local filename = vim.fn.expand('%:t')
  local parent = vim.fn.expand('%:h:t')

  if parent == '.' then
    return filename
  end

  return parent .. '/' .. filename
end

function filetype()
  return vim.bo.filetype
end

function fileformat()
  local formats = {
    unix = 'lf',
    mac = 'cr',
    dos = 'crlf',
  }

  return formats[vim.bo.fileformat]
end

function location()
  local total = vim.api.nvim_buf_line_count(0)
  local line, char = unpack(vim.api.nvim_win_get_cursor(0))

  return char .. '-' .. line .. '/' .. total
end

function lsp()
  local filetype = vim.bo.filetype
  local active_clients = vim.lsp.get_active_clients()

  if not next(clients) then
    return ''
  end

  local clients = ''
  for _, client in ipairs(active_clients) do
    local filetypes = client.config.filetypes

    if filetypes and vim.fn.index(filetypes, filetype) ~= -1 then
      clients = clients .. client .. ' '
    end
  end

  return clients:sub(1, -2)
end

return { 'nvim-lualine/lualine.nvim',
  name = 'lualine',
  event = "VeryLazy",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function(_, opts)
    local flavour = vim.g.colors_name:gsub('catppuccin--', '')
    local colors = require 'catppuccin.palettes'.get_palette(flavour)

    function scheme(color)
      return {
        a = { bg = color, fg = colors.mantle, gui = 'bold' },
        b = { bg = colors.mantle, fg = color.text },
        c = { bg = colors.crust, fg = colors.overlay1 },
      }
    end

    -- just a "rewrite" of catppuccin theme
    -- https://github.com/catppuccin/nvim/blob/main/lua/catppuccin/utils/lualine.lua
    opts.options.theme = {
      normal = scheme(colors.blue),
      visual = scheme(colors.yellow),
      block = scheme(colors.pink),
      insert = scheme(colors.green),
      replace = scheme(colors.red),
      command = scheme(colors.peach),
      terminal = scheme(colors.sky),
      inactive = {
        a = { bg = colors.mantle, fg = colors.blue },
        b = { bg = colors.mantle, fg = colors.surface1, gui = 'bold' },
        c = { bg = colors.mantle, fg = colors.overlay0 },
      }
    }

    require 'lualine'.setup(opts)
  end,
  opts = {
    options = {
      icons_enabled = true,
      component_separators = '',
      section_separators = '',
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { filename },
      lualine_c = { 'branch', 'diff' },
      lualine_x = { 'encoding', fileformat, filetype },
      lualine_y = { 'diagnostics', lsp },
      lualine_z = { location },
    }
  }
}

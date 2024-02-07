return { 'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false, priority = 1000,
  config = function(_, opts)
    require 'catppuccin'.setup(opts)

    vim.cmd.colorscheme 'catppuccin'
  end,
  opts = {
    flavour = "mocha",
    integrations = {
      barbar = true,
      cmp = true,
    },
    custom_highlights = function(colors)
      return {
        CursorLineNr = { fg = colors.yellow }
      }
    end
  }
}

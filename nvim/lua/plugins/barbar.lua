return { 'romgrk/barbar.nvim',
  name = 'barbar',
  event = 'VimEnter',
  dependencies = {
    { 'lewis6991/gitsigns.nvim', name = 'gitsigns' },
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    options = {
      animation = false,
      focus_on_close = 'previous',
      hide = { extensions = false }
    }
  }
}

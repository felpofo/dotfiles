return { 'romgrk/barbar.nvim',
  name = 'barbar',
  event = 'VimEnter',
  opts = {
    options = {
      animation = false,
      focus_on_close = 'previous',
      hide = { extensions = false }
    }
  }
}

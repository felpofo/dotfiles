return { 'nvim-tree/nvim-tree.lua',
  name = 'nvim-tree',
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
  dependencies = { 'nvim-web-devicons' },
  opts = {
    filters = {
      dotfiles = false,
      exclude = { vim.fn.stdpath('config') .. '/lua/custom' },
    },
    disable_netrw = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    view = {
      side = 'left',
      width = 30,
      preserve_window_proportions = true,
    },
    git = {
      enable = true,
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      root_folder_label = false,
      highlight_git = true,
      highlight_opened_files = 'none',
      indent_markers = {
        enable = false,
      },
      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },
      }
    }
  }
}

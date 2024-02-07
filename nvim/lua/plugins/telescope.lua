return { 'nvim-telescope/telescope.nvim',
  name = 'telescope',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require 'telescope'.setup {
      vimgrep_arguments = {
        'rg', '-L',
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
      },
      prompt_prefix = '   ',
      selection_caret = '  ',
      entry_prefix = '  ',
      initial_mode = 'insert',
      selection_strategy = 'reset',
      sorting_strategy = 'ascending',
      layout_strategy = 'horizontal',
      layout_config = {
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
      },
      file_sorter = require 'telescope.sorters'.get_fuzzy_file,
      file_ignore_patterns = { 'node_modules', '.git' },
      generic_sorter = require 'telescope.sorters'.get_generic_fuzzy_sorter,
      path_display = { 'truncate' },
      winblend = 0,
      border = {},
      borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
      color_devicons = true,
      set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
      grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
      qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,
      buffer_previewer_maker = require 'telescope.previewers'.buffer_previewer_maker,
    }
  end
}

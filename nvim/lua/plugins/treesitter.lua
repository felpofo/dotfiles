return { 'nvim-treesitter/nvim-treesitter',
  name = 'treesitter',
  event = 'BufReadPost',
  cmd = { 'TSInstall', 'TSBufEnable', 'TSBufDisable', 'TSModuleInfo' },
  build = ':TSUpdate',
  config = function(_, opts)
    require 'nvim-treesitter.configs'.setup(opts)
  end,
  opts = {
    sync_install = false,
    auto_install = true,
    indent = { enable = true },
    highlight = {
      enable = true,
      use_languagetree = true,
      additional_vim_regex_highlighting = false,
    },
    ensure_installed = {
      'lua', 'c', 'cpp', 'rust', 'zig', 'python', 'go',
      'html', 'css', 'scss', 'javascript', 'typescript', 'svelte',
      'ssh_config', 'git_config', 'gitignore',
      'terraform', 'sql',
      'xml', 'yaml', 'toml', 'ini',
      'glsl', 'hlsl',
      'bash', 'fish',
    }
  }
}

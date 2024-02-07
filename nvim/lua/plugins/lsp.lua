return { 'neovim/nvim-lspconfig',
  name = 'lspconfig',
  event = { 'BufReadPost', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim',
      name = 'mason',
      lazy = false,
      config = true
    },
    { 'williamboman/mason-lspconfig.nvim', name = 'mason-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp', name = 'cmp-lsp' }
  },
  config = function(_, opts)
    local lsp = require 'lspconfig'

    vim.diagnostic.config(opts.diagnostics)

    local capabilities = require 'cmp_nvim_lsp'.default_capabilities()
    local function setup(server)
      local server_opts = opts.servers[server]
      server_opts.capabilities = capabilities

      lsp[server].setup(server_opts)
    end

    local mason_ok, mason_lsp = pcall(require, 'mason-lspconfig')
    local installed_servers = mason_ok and vim.tbl_keys(require 'mason-lspconfig.mappings.server'.lspconfig_to_package) or {}
    local missing_servers = {}

    for server, server_opts in pairs(opts.servers) do
      if server_opts.mason == false or not vim.tbl_contains(installed_servers, server) then
        setup(server)
      else
        missing_servers[#missing_servers + 1] = server
      end
    end

    if mason_ok then
      mason_lsp.setup {
        ensure_installed = missing_servers,
        handlers = { setup }
      }
    end
  end,
  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = 'if_many',
        prefix = '󰧞'
      },
      severity_sort = true
    },
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {
                'vim'
              }
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('', true)
            },
            telemetry = {
              enable = false
            }
          }
        }
      },
      clangd = {},
      rust_analyzer = {},
      pyright = {},
      gopls = {},
    }
  }
}

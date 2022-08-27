-- setup debugger based on vscode plugin - if this breaks chances are the plugin got updated so alter the path to match on next line...
local extension_path = vim.env.HOME .. '/.vscode-oss/extensions/vadimcn.vscode-lldb-1.7.0/'
-- This version has required a dirty patch to ~/.local/share/nvim/site/pack/packer/start/rust-tools.nvim/lua/rust-tools/dap.lua
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'

local lsp_on_attach = require('lsp_keymap_function').on_attach

local opts = {
  -- rust-tools options
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
	-- override the default hover_actions
  hover_actions = {
    auto_focus = true,
  },
  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
  -- https://rust-analyzer.github.io/manual.html#features
  server = {
    on_attach = lsp_on_attach,
    settings = {
      ["rust-analyzer"] = {
        assist = {
          importEnforceGranularity = true,
          importPrefix = "crate"
          },
        cargo = {
          allFeatures = true
          },
        checkOnSave = {
          -- default: `cargo check`
          command = "clippy"
          },
        },
        inlayHints = {
          lifetimeElisionHints = {
            enable = true,
            useParameterNames = true
          },
        },
      }
    },
    -- dap = {
    --    adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
    -- },
}
require('rust-tools').setup(opts)


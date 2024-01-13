local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lsp_on_attach = require('lsp_keymap_function').on_attach

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
vim.api.nvim_create_user_command('LspFmt', 'lua vim.lsp.buf.format()', {})

-- ----------------------------------------------------------------------
--  rayx/go
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require('go.format').goimport()
    end,
    group = format_sync_grp,
})

require('go').setup({
    -- other setups ....
    lsp_cfg = {
        capabilities = capabilities,
        -- other setups
        on_attach = lsp_on_attach,
    },
})
---- // rayx/go

---- LUA LSP

--require'lspconfig'.sumneko_lua.setup{}
nvim_lsp.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
    on_attach = lsp_on_attach,
}

nvim_lsp.pylsp.setup {
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = { 'W391' },
                    maxLineLength = 100
                }
            }
        }
    },
    on_attach = lsp_on_attach,
}
---- // LUA LSP

---- // OCAML LSP
nvim_lsp.ocamllsp.setup {}
---- // OCAML LSP

-- // ROME - typescript html css etc linter/lsp
-- require 'lspconfig'.rome.setup {}
-- DIDN'T WORK FOR COMPLETIONS, WHICH SHOULD AS NVIM-CMP HAS LSP AS A PROVIDER

-- TypeScript
nvim_lsp.tsserver.setup {
    on_attach = lsp_on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
}


-- OmniSharp - i.e c#
local pid = vim.fn.getpid()
local omnisharp_bin = "/opt/omnisharp/OmniSharp"
-- if you are getting errors, it might be .net has been updated, need to update ~/.omnisharp/omnisharp.json
nvim_lsp.omnisharp.setup(
    {
        handlers = {
            ["textDocument/definition"] = require('omnisharp_extended').handler,
        },
        cmd = { omnisharp_bin, }, --'--languageserver', '--hostPID', tostring(pid) },
        -- rest of your settings
        enable_editorconfig_support = true,
        on_attach = lsp_on_attach,
    })

-- require('omnisharp_extended').lsp_definitions()
-- require('omnisharp_extended').telescope_lsp_definitions()

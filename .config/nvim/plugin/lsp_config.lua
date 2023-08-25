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

---- GO LSP
nvim_lsp.gopls.setup {
    cmd = { 'gopls' },
    -- for postfix snippets and analyzers
    capabilities = capabilities,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        },
    },
    on_attach = lsp_on_attach,
}

-- function goimports(timeout_ms)
--     local context = { source = { organizeImports = true } }
--     vim.validate { context = { context, "t", true } }
--
--     local params = vim.lsp.util.make_range_params()
--     params.context = context
--
--     -- See the implementation of the textDocument/codeAction callback
--     -- (lua/vim/lsp/handler.lua) for how to do this properly.
--     local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
--     if not result or next(result) == nil or result[1] == nil then return end
--     local actions = result[1].result
--     if not actions then return end
--     local action = actions[1]
--
--     -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
--     -- is a CodeAction, it can have either an edit, a command or both. Edits
--     -- should be executed first.
--     if action.edit or type(action.command) == "table" then
--         if action.edit then
--             vim.lsp.util.apply_workspace_edit(action.edit)
--         end
--         if type(action.command) == "table" then
--             vim.lsp.buf.execute_command(action.command)
--         end
--     else
--         vim.lsp.buf.execute_command(action)
--     end
-- end
--
-- --vim.lsp.set_log_level("debug")
--
-- vim.cmd [[
-- " autocmd BufWritePre *.go lua vim.lsp.buf.format()
-- autocmd BufWritePre *.go lua goimports(1000)
-- ]]
vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
        vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
    end
})
---- // GO LSP

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
    }
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
    on_attach = on_attach,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" }
}


-- OmniSharp - i.e c#
local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = "/opt/omnisharp/OmniSharp"
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"

local omni_config = {
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler,
    },
    cmd = { omnisharp_bin, '--languageserver', '--hostPID', tostring(pid) },
    -- rest of your settings
    enable_editorconfig_support = true,

}

nvim_lsp.omnisharp.setup(omni_config)
-- require('omnisharp_extended').lsp_definitions()
-- require('omnisharp_extended').telescope_lsp_definitions()

-- Enable LSP servers
vim.lsp.enable('clangd')
vim.lsp.enable('pyright')
vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("jsonls")

local map = vim.keymap.set

-- Navigation
map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
map('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
map('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
map('n', 'gr', vim.lsp.buf.references, { desc = 'Show references' })
map('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover' })

-- Refactor / actions
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
map({ 'n', 'x' }, '<leader>a', vim.lsp.buf.code_action, { desc = 'Code actions' })
map('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format buffer' })
map('x', '<leader>f', vim.lsp.buf.format, { desc = 'Format selection' })
map('n', '<leader>cl', vim.lsp.codelens.run, { desc = 'Run code lens' })

-- Diagnostics
map('n', '[g', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
map('n', ']g', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })

local ok, fzf = pcall(require, "fzf-lua")

if ok then
    map("n", "<leader>go", fzf.lsp_document_symbols, { desc = "Document symbols" })
    map("n", "<leader>ws", fzf.lsp_workspace_symbols, { desc = "Workspace symbols" })
    map("n", "<leader>ga", fzf.diagnostics_document, { desc = "Document diagnostics" })
    -- 或者：
    -- map("n", "a", fzf.diagnostics_workspace, { desc = "Workspace diagnostics" })
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        if client:supports_method("textDocument/documentHighlight") then
            vim.api.nvim_create_autocmd("CursorHold", {
                buffer = ev.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = ev.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})

-- Organize imports
vim.api.nvim_create_user_command('OR', function()
  vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
end, {})


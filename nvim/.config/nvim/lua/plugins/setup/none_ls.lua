return {
    'nvimtools/none-ls.nvim',
    ft = {
        'go',
        'c',
        'rust',
        'bash',
        'cpp',
        'python',
        'lua',
        'java',
        'php',
        'javascript',
        'typescript',
        'typescriptreact',
        'javascriptreact',
    },
    opts = function()
        local null_ls = require('null-ls')
        local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

        return {
            sources = {
                -- Lua Formatter
                null_ls.builtins.formatting.stylua.with({
                    extra_args = {
                        '--indent-type',
                        'spaces',
                        '--indent-width',
                        '2',
                        '--quote-style',
                        'AutoPreferSingle',
                    },
                }),

                -- Prettier for multiple filetypes
                null_ls.builtins.formatting.prettier,

                -- PHP Formatter
                null_ls.builtins.formatting.phpcsfixer.with({ filetypes = { 'html', 'php', 'phtml' } }),

                -- Java Formatter
                null_ls.builtins.formatting.google_java_format.with({ extra_args = { '--aosp' } }),

                -- Python Formatter
                null_ls.builtins.formatting.black,

                -- C/C++ Formatter
                null_ls.builtins.formatting.clang_format.with({ filetypes = { 'c', 'cpp', 'proto' } }),

                -- Rust Formatter
                null_ls.builtins.formatting.rustywind,

                -- Bash Formatter
                null_ls.builtins.formatting.shfmt.with({ args = { '-i', '2' } }),
            },
            on_attach = function(client, bufnr)
                if client.supports_method('textDocument/formatting') then
                    vim.api.nvim_clear_autocmds({
                        group = augroup,
                        buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd('BufWritePre', {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr })
                        end,
                    })
                end
            end,
        }
    end,
}

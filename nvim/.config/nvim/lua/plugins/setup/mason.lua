return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
        { 'williamboman/mason.nvim',           opts = true },
        { 'williamboman/mason-lspconfig.nvim', opts = true },
    },
    lazy = false,
    opts = {
        ensure_installed = {
            -- Lua
            'lua-language-server',
            'stylua',
            -- Web
            'css-lsp',
            'html-lsp',
            'typescript-language-server',
            'deno',
            'prettier',
            'prettierd',
            'emmet-ls',
            -- Java
            'jdtls',
            'java-test',
            'google-java-format',
            -- C/C++ Tools
            'clangd',
            'clang-format',
            -- Rust
            'rustywind',
            -- Bash
            'shellcheck',
            { 'bash-language-server', auto_update = true },
            'shfmt',
            -- PHP
            'phpactor',
            'php-debug-adapter',
            'php-cs-fixer',
            -- Python
            'pyright',
            'flake8',
            'black',
            'debugpy',
            'mypy',
            'pydocstyle',
            'pylint',
            'pyre',
            'autoflake',
            'autopep8',
            'python-lsp-server',
        },
    },
}

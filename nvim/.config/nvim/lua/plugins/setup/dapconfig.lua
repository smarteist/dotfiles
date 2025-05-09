return {
    'mfussenegger/nvim-dap',
    config = function()
        local dap = require('dap')

        -- ================================
        --         Highlight Settings
        -- ================================

        -- Define custom highlight groups
        vim.api.nvim_set_hl(0, 'red', { fg = '#ed0d09' })
        vim.api.nvim_set_hl(0, 'green', { fg = '#9ece6a' })
        vim.api.nvim_set_hl(0, 'yellow', { fg = '#FFFF00' })
        vim.api.nvim_set_hl(0, 'orange', { fg = '#f09000' })

        -- ================================
        --             Signs
        -- ================================

        -- Define signs for DAP
        vim.fn.sign_define('DapBreakpoint', {
            text = '⊚',
            texthl = 'red',
            linehl = 'DapBreakpoint',
            numhl = 'DapBreakpoint',
        })

        vim.fn.sign_define('DapBreakpointCondition', {
            text = '',
            texthl = 'red',
            linehl = 'DapBreakpoint',
            numhl = 'DapBreakpoint',
        })

        vim.fn.sign_define('DapBreakpointRejected', {
            text = '▣',
            texthl = 'orange',
            linehl = 'DapBreakpoint',
            numhl = 'DapBreakpoint',
        })

        vim.fn.sign_define('DapStopped', {
            text = '🡪',
            texthl = 'green',
            linehl = 'DapBreakpoint',
            numhl = 'DapBreakpoint',
        })

        vim.fn.sign_define('DapLogPoint', {
            text = '',
            texthl = 'yellow',
            linehl = 'DapBreakpoint',
            numhl = 'DapBreakpoint',
        })

        -- ================================
        --         Adapter Configs
        -- ================================

        -- Python Adapter
        dap.adapters.python = {
            type = 'executable',
            command = vim.fn.system('printf $(dirname "$(realpath "$(which debugpy)")")/venv/bin/python'),
            args = { '-m', 'debugpy.adapter' },
        }

        -- PHP Adapter
        dap.adapters.php = {
            type = 'executable',
            command = 'node',
            args = {
                vim.fn.stdpath('data') .. '/mason/packages/php-debug-adapter/extension/out/phpDebug.js',
            },
        }

        -- Java Adapter
        dap.adapters.java = {
            type = 'server',
            host = '127.0.0.1',
            port = 5005,
        }

        -- Rust/C/C++ Adapter (CodeLLDB)
        dap.adapters.codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                -- Replace with the path to your CodeLLDB executable
                command = vim.fn.stdpath('data') .. '/mason/packages/codelldb/extension/codelldb',
                args = { '--port', '${port}' },

                -- On Windows, you may need to uncomment the following line:
                -- detached = false,
            },
        }

        -- ================================
        --        Configuration Settings
        -- ================================

        -- Python Configuration
        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = 'Launch File',
                program = '${file}',
                args = {}, -- You can customize arguments here
                pythonPath = function()
                    -- Determines the Python interpreter to use
                    local current_python = vim.fn.system('which python')
                    return vim.trim(current_python)
                end,
            },
        }

        -- PHP Configuration
        dap.configurations.php = {
            {
                name = 'Listen for XDebug',
                type = 'php',
                request = 'launch',
                port = 9003,
                serverSourceRoot = vim.fn.getcwd() .. '/',
                ignore = { '**/vendor/**/*.php' },
                hostname = '127.0.0.1',
            },
            {
                name = 'Launch Currently Open Script',
                type = 'php',
                request = 'launch',
                program = '${file}',
                cwd = '${fileDirname}',
                port = 9003,
            },
        }

        -- Java Configuration
        dap.configurations.java = {
            {
                name = 'Debug (Attach) - Remote',
                type = 'java',
                request = 'attach',
                hostName = '127.0.0.1',
                port = 5005,
            },
            {
                name = 'Debug Non-Project Class',
                type = 'java',
                request = 'launch',
                program = '${file}',
            },
        }

        -- Rust/C/C++ Configuration
        dap.configurations.rust = {
            {
                name = 'Launch File',
                type = 'codelldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            },
        }
    end,
}

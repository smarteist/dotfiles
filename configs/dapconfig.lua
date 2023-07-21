local dap = require 'dap'

vim.api.nvim_set_hl(0, 'red', { fg = '#ed0d09' })
vim.api.nvim_set_hl(0, 'green', { fg = '#9ece6a' })
vim.api.nvim_set_hl(0, 'yellow', { fg = '#FFFF00' })
vim.api.nvim_set_hl(0, 'orange', { fg = '#f09000' })

vim.fn.sign_define(
  'DapBreakpoint',
  { text = '⊚', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)
vim.fn.sign_define(
  'DapBreakpointCondition',
  { text = '', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)
vim.fn.sign_define(
  'DapBreakpointRejected',
  { text = '▣', texthl = 'orange', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)
vim.fn.sign_define(
  'DapStopped',
  { text = '🡪', texthl = 'green', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)
vim.fn.sign_define(
  'DapLogPoint',
  { text = '', texthl = 'yellow', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' }
)

-- Python
dap.adapters.python = {
  type = 'executable',
  command = vim.fn.system 'printf $(dirname "$(realpath "$(which debugpy)")")' .. '/venv/bin/python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python', -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch',
    name = 'Launch file',
    program = '${file}', -- This configuration will launch the current file if used.
    args = prompt_args,
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local currentpythonpath = vim.fn.system 'printf $(which python)'
      return currentpythonpath
    end,
  },
}

-- PHP
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = {
    require('mason-registry').get_package('php-debug-adapter'):get_install_path() .. '/extension/out/phpDebug.js',
  },
}

dap.configurations.php = {
  {
    name = 'Listen for XDebug',
    type = 'php',
    request = 'launch',
    port = 9003,
    serverSourceRoot = vim.fn.getcwd() .. '/',
    -- stopOnEntry = true,
    ignore = {
      '**/vendor/**/*.php',
    },
    hostname = '127.0.0.1',
  },
  {
    name = 'Launch currently open script',
    type = 'php',
    request = 'launch',
    program = '${file}',
    cwd = '${fileDirname}',
    port = 9003,
  },
}

-- Java
dap.adapters.java = {
  type = 'server',
  host = '127.0.0.1',
  port = 5005,
}

dap.configurations.java = {
  {
    name = 'Debug (Attach) - Remote',
    type = 'java',
    request = 'attach',
    hostName = '127.0.0.1',
    port = 5005,
  },
  {
    name = 'Debug Non-Project class',
    type = 'java',
    request = 'launch',
    program = '${file}',
  },
}

-- Rust/C/C++
dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    -- CHANGE THIS to your path!
    command = require('mason-registry').get_package('codelldb'):get_install_path() .. '/extension/adapter/codelldb',
    args = { '--port', '${port}' },

    -- On windows you may have to uncomment this:
    -- detached = false,
  },
}

dap.configurations.rust = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

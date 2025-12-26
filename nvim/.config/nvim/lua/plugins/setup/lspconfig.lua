return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
  },
  config = function()
    local util = require('lspconfig.util')

    -- NvChad Settings
    local lsp_settings = require('nvchad.configs.lspconfig')
    local on_attach = lsp_settings.on_attach
    local on_init = lsp_settings.on_init
    local lsp_flags = lsp_settings.lsp_flags
    local extendedClientCapabilities = lsp_settings.extendedClientCapabilities

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- Reusable setup function
    local function setup_server(server_name, config)
      config = config or {}

      -- Merge defaults
      config.on_attach = config.on_attach or on_attach
      config.capabilities = config.capabilities or capabilities
      config.flags = config.flags or lsp_flags
      config.on_init = config.on_init or on_init

      -- Check custom cmd
      if config.cmd and vim.fn.executable(config.cmd[1]) == 0 then
        vim.notify('Mason tool not found: ' .. config.cmd[1], vim.log.levels.ERROR)
        return
      end

      -- Register and Enable
      vim.lsp.config(server_name, config)
      vim.lsp.enable(server_name)
    end

    -- ----- Python (Pyright) -----
    setup_server('pyright', {
      filetypes = { 'python' },
      settings = {
        python = {
          analysis = {
            diagnosticSeverityOverrides = {
              reportMissingImports = 'none',
            },
          },
        },
      },
      root_dir = util.root_pattern('pyproject.toml', 'requirements.txt', 'Pipfile', 'poetry.lock', '.git')(
        vim.fn.getcwd()
      ),
    })

    -- ----- Java (jdtls) -----
    setup_server('jdtls', {
      filetypes = { 'java' },
      -- Explicit root_dir override
      root_dir = util.root_pattern('mvnw', 'gradlew', 'pom.xml', 'build.gradle', '.git')(vim.fn.getcwd()),
      settings = {
        java = {
          eclipse = { downloadSources = true },
          configuration = { updateBuildConfiguration = 'interactive' },
          maven = { downloadSources = true },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          references = { includeDecompiledSources = true },
          inlayHints = { parameterNames = { enabled = 'all' } },
          format = {
            enabled = true,
            settings = {
              url = 'https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml',
              profile = 'GoogleStyle',
            },
          },
        },
        signatureHelp = { enabled = true },
        completion = {
          favoriteStaticMembers = {
            'org.hamcrest.MatcherAssert.assertThat',
            'org.hamcrest.Matchers.*',
            'org.hamcrest.CoreMatchers.*',
            'org.junit.jupiter.api.Assertions.*',
            'java.util.Objects.requireNonNull',
            'java.util.Objects.requireNonNullElse',
            'org.mockito.Mockito.*',
          },
        },
        contentProvider = { preferred = 'fernflower' },
        extendedClientCapabilities = extendedClientCapabilities,
        sources = {
          organizeImports = {
            starThreshold = 9999,
            staticStarThreshold = 9999,
          },
        },
        codeGeneration = {
          toString = {
            template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
          },
          useBlocks = true,
        },
      },
      init_options = {
        bundles = {},
      },
    })

    -- ----- TypeScript & JavaScript (ts_ls) -----
    setup_server('ts_ls', {
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
      },
      root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(vim.fn.getcwd()),
    })

    -- ----- PHP (phpactor) -----
    setup_server('phpactor', {
      filetypes = { 'php' },
      root_dir = util.root_pattern(
        'composer.json',
        'composer.lock',
        'phpunit.xml',
        'phpunit.xml.dist',
        'artisan',
        '.git'
      )(vim.fn.getcwd()),
    })

    -- ----- HTML (html) -----
    setup_server('html', {
      filetypes = { 'html' },
      root_dir = util.root_pattern('.git')(vim.fn.getcwd()),
    })

    -- ----- CSS/SASS/SCSS (cssls) -----
    setup_server('cssls', {
      filetypes = { 'css', 'sass', 'scss' },
      root_dir = util.root_pattern('.git')(vim.fn.getcwd()),
    })

    -- ----- Emmet (emmet_ls) -----
    setup_server('emmet_ls', {
      filetypes = {
        'css',
        'html',
        'javascriptreact',
        'less',
        'sass',
        'scss',
        'typescriptreact',
        'php',
      },
    })

    -- ----- Lua (lua_ls) -----
    setup_server('lua_ls', {
      settings = {
        Lua = {
          diagnostics = { globals = { 'vim' } },
        },
      },
    })

    -- ----- C/C++ (clangd) -----
    setup_server('clangd', {
      filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
      root_dir = util.root_pattern(
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
        '.git'
      )(vim.fn.getcwd()),
    })

    -- ----- Bash (bashls) -----
    setup_server('bashls', {
      filetypes = { 'sh', 'bash', 'zsh' },
    })
  end,
}

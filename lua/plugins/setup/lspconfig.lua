return {
  'neovim/nvim-lspconfig',
  config = function()
    -- ================================
    --        Require Necessary Modules
    -- ================================
    local lspconfig = require('lspconfig')
    local util = require('lspconfig/util')

    -- Import NvChad's LSP settings
    local lsp_settings = require('nvchad.configs.lspconfig')
    local on_attach = lsp_settings.on_attach
    local on_init = lsp_settings.on_init
    local lsp_flags = lsp_settings.lsp_flags
    local extendedClientCapabilities = lsp_settings.extendedClientCapabilities

    -- Enhance capabilities with nvim-cmp
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    -- ================================
    --           LSP Server Configurations
    -- ================================

    -- Helper function to reduce repetition
    local function setup_server(server_name, config)
      config = config or {}
      config.on_attach = on_attach
      config.capabilities = capabilities
      lspconfig[server_name].setup(config)
    end

    -- ----- Python (Pyright) -----
    setup_server('pyright', {
      filetypes = { 'python' },
    })

    -- ----- Java (jdtls) -----
    setup_server('jdtls', {
      flags = lsp_flags,
      filetypes = { 'java' },
      root_dir = util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
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
        bundles = {}, -- Add paths to jar files if using additional eclipse.jdt.ls plugins
      },
    })

    -- ----- Rust (rust_analyzer) -----
    setup_server('rust_analyzer', {
      filetypes = { 'rust' },
      root_dir = util.root_pattern('Cargo.toml'),
    })

    -- ----- TypeScript & JavaScript (tsserver) -----
    setup_server('ts_ls', {
      on_init = on_init,
      cmd = { 'typescript-language-server', '--stdio' },
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
      },
      root_dir = function()
        return util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git')(vim.fn.getcwd())
      end,
    })

    -- ----- PHP (phpactor) -----
    setup_server('phpactor', {
      filetypes = { 'php' },
      root_dir = function()
        return vim.loop.cwd()
      end,
    })

    -- ----- HTML (html) -----
    setup_server('html', {
      filetypes = { 'html' },
      root_dir = function()
        return vim.loop.cwd()
      end,
    })

    -- ----- CSS/SASS/SCSS (cssls) -----
    setup_server('cssls', {
      flags = lsp_flags,
      filetypes = { 'css', 'sass', 'scss' },
      root_dir = function()
        return vim.loop.cwd()
      end,
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

    -- Add additional LSP server configurations here following the same pattern
  end,
}

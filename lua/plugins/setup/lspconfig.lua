return {
  'neovim/nvim-lspconfig',
  config = function()
    -- ================================
    --        Require Necessary Modules
    -- ================================
    local on_attach = require('nvchad.configs.lspconfig').on_attach
    local on_init = require('nvchad.configs.lspconfig').on_init
    local capabilities = require('nvchad.configs.lspconfig').capabilities
    local lsp_flags = require('nvchad.configs.lspconfig').lsp_flags
    local extendedClientCapabilities = require('nvchad.configs.lspconfig').extendedClientCapabilities

    local lspconfig = require('lspconfig')
    local util = require('lspconfig/util')

    -- ================================
    --           LSP Server Configurations
    -- ================================

    -- ----- Python (Pyright) -----
    lspconfig.pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'python' },
    })

    -- ----- Java (jdtls) -----
    lspconfig.jdtls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
      filetypes = { 'java' },
      root_dir = lspconfig.util.root_pattern('.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'),
      flags = {
        allow_incremental_sync = true,
      },
      settings = {
        java = {
          eclipse = {
            downloadSources = true,
          },
          configuration = {
            updateBuildConfiguration = 'interactive',
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true,
          },
          referencesCodeLens = {
            enabled = true,
          },
          references = {
            includeDecompiledSources = true,
          },
          inlayHints = {
            parameterNames = {
              enabled = 'all', -- literals, all, none
            },
          },
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
    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'rust' },
      root_dir = lspconfig.util.root_pattern('Cargo.toml'),
    })

    -- ----- TypeScript & JavaScript (tsserver) -----
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
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
    lspconfig.phpactor.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'php' },
      root_dir = function()
        return vim.loop.cwd()
      end,
    })

    -- ----- HTML (html) -----
    lspconfig.html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'html' },
      root_dir = function()
        return vim.loop.cwd()
      end,
    })

    -- ----- CSS/SASS/SCSS (cssls) -----
    lspconfig.cssls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      flags = lsp_flags,
      filetypes = { 'css', 'sass', 'scss' },
      root_dir = function()
        return vim.loop.cwd()
      end,
    })

    -- ----- Emmet (emmet_ls) -----
    lspconfig.emmet_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
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

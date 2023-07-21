local on_attach = require('plugins.configs.lspconfig').on_attach
local capabilities = require('plugins.configs.lspconfig').capabilities

local lspconfig = require 'lspconfig'
local util = require 'lspconfig/util'

-- Python
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'python',
  },
}

-- jdtls is a sh script in path which bootsup jdtls
lspconfig.jdtls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  filetypes = {
    'java',
  },
  root_dir = lspconfig.util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
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
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}

-- Rust
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'rust',
  },
  root_dir = lspconfig.util.root_pattern 'Cargo.toml',
}

-- JS TS ...
lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {
    'typescript-language-server',
    '--stdio',
  },
  filetypes = {
    'javascript',
    'javascriptreact',
    'javascript.jsx',
    'typescript',
    'typescriptreact',
    'typescript.tsx',
  },
  root_dir = util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
  root_dir = function()
    return vim.loop.cwd()
  end,
}

-- PHP
lspconfig.phpactor.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'php',
  },
  root_dir = function()
    return vim.loop.cwd()
  end,
}

-- HTML
lspconfig.html.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'html',
  },
  root_dir = function()
    return vim.loop.cwd()
  end,
}

-- S(C|A)SS
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = lsp_flags,
  filetypes = {
    'css',
    'sass',
    'scss',
  },
  root_dir = function()
    return vim.loop.cwd()
  end,
}

-- Emmet
lspconfig.emmet_ls.setup {
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
}

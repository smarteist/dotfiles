local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

-- Python
lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"python",
	},
})

-- Java
lspconfig.jdtls.setup({
	capabilities = capabilities,
	flags = lsp_flags,
	on_attach = on_attach,
	filetypes = {
		"java",
	},
	settings = {},
	root_dir = function()
		return vim.loop.cwd()
	end,
})

-- Rust
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"rust",
	},
	root_dir = lspconfig.util.root_pattern("Cargo.toml"),
})

-- JS TS ...
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"typescript-language-server",
		"--stdio",
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	-- root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
	root_dir = function()
		return vim.loop.cwd()
	end,
})

-- PHP
lspconfig.phpactor.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"php",
	},
	root_dir = function()
		return vim.loop.cwd()
	end;
})

-- HTML
lspconfig.html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"html",
	},
	root_dir = function()
		return vim.loop.cwd()
	end;
})

-- S(C|A)SS
lspconfig.cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	flags = lsp_flags,
	filetypes = {
		"css",
		"sass",
		"scss",
	},
	root_dir = function()
		return vim.loop.cwd()
	end;
})


-- Emmet
lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = snip_caps,
	filetypes = {
		"css",
		"html",
		"javascriptreact",
		"less",
		"sass",
		"scss",
		"typescriptreact",
		"php",
	},
})





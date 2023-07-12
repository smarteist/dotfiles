local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

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

lspconfig.pyright.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
		"python",
	},
})

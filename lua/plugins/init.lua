
local overrides = require("configs.overrides")
local null_ls_cfg = require("configs.null-ls")

---@type NvPluginSpec[]
local plugins = {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		config = function()
		require "configs.conform"
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
-- 	{
-- 		"github/copilot.vim",
-- 		lazy = false,
-- 		config = function() end,
-- 	},
-- 	{
-- 		"zbirenbaum/copilot.lua",
-- 		cmd = "Copilot",
-- 		event = "InsertEnter",
-- 		opts = overrides.copilot,
-- 	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			{ "williamboman/mason.nvim", opts = true },
			{ "williamboman/mason-lspconfig.nvim", opts = true },
		},
		opts = overrides.mason,
		lazy = false,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require "configs.lspconfig"
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = null_ls_cfg.ft,
		opts = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			return null_ls_cfg.opts(null_ls, augroup)
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},
	{
		"vimwiki/vimwiki",
		lazy = false,
		config = function() end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			require("configs.dapconfig")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = "python",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		}
	},
	{
		"m4xshen/autoclose.nvim",
		event = "BufEnter",
		config = function()
			require("autoclose").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
		opts = overrides.nvimcmp,
	},
}

return plugins

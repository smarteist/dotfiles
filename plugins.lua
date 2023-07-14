local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	{
		"github/copilot.vim",
		lazy = false,
		config = function() end,
	},
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = {
			"go",
			"python",
			"lua",
			"javascript",
			"typescript",
			"typescriptreact",
			"javascriptreact",
		},
		opts = function()
			local custom_null_ls = require("custom.configs.null-ls")
			return custom_null_ls
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
			require "custom.configs.dapconfig"
		end,
		init = function()
			require("core.utils").load_mappings("dap")
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = "mfussenegger/nvim-dap",
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
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = overrides.copilot,
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

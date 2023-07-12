---@type MappingsTable
local M = {}

M.dap = {
	plugin = true,
	n = {
		["<leader>dd"] = {"<cmd>lua require('dap').continue()<CR>", "Start Debugging"},
		["<leader>du"] = {"<cmd>lua require('dapui').toggle({ reset = true })<CR>", "Toggle Dap UI"},
		["<leader>de"] = {"<cmd>lua require('dapui').eval()<CR>", "Dap UI Eval"},
		["<leader>db"] = {"<cmd>lua require('dap').toggle_breakpoint()<CR>", "Toggle Breakpoint"},
		["<leader>di"] = {"<cmd>lua require('dap').step_into()<CR>", "Step Into"},
		["<leader>do"] = {"<cmd>lua require('dap').step_out()<CR>", "Step Out"},
		["<leader>dO"] = {"<cmd>lua require('dap').step_over()<CR>", "Step Over"},
		["<leader>dj"] = {"<cmd>lua require('dap').down()<CR>", "Down"},
		["<leader>dk"] = {"<cmd>lua require('dap').up()<CR>", "Up"},
		["<leader>dp"] = {"<cmd>lua require('dap').pause()<CR>", "Pause"},
		["<leader>dc"] = {"<cmd>lua require('dap').continue()<CR>", "Continue"},
		["<leader>dl"] = {"<cmd>lua require('dap').run_last()<CR>", "Run Last"},
		["<leader>dC"] = {"<cmd>lua require('dap').run_to_cursor()<CR>", "Run to Cursor"},
		["<leader>dt"] = {"<cmd>lua require('dap').terminate()<CR>", "Terminate"},
		["<leader>ds"] = {"<cmd>lua require('dap').session()<CR>", "Session"},
		["<leader>dr"] = {"<cmd>lua require('dap').repl.toggle()<CR>", "Toggle REPL"},
		["<leader>dw"] = {"<cmd>lua require('dap.ui.widgets').hover()<CR>", "Widgets"},
	},
}

M.dap_python = {
	plugin = true,
	n = {
		["<leader>dpr"] = {
			function()
				require("dap-python").test_method()
			end,
		},
	},
}




return M

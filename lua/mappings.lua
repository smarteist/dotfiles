require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>dd", "<cmd>lua require('dap').continue()<CR>", { desc = "Start Debugging" })
map("n", "<leader>du", "<cmd>lua require('dapui').toggle({ reset = true })<CR>", { desc = "Toggle Dap UI" })
map("n", "<leader>de", "<cmd>lua require('dapui').eval()<CR>", { desc = "Dap UI Eval" })
map("n", "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
map("n", "<leader>di", "<cmd>lua require('dap').step_into()<CR>", { desc = "Step Into" })
map("n", "<leader>do", "<cmd>lua require('dap').step_out()<CR>", { desc = "Step Out" })
map("n", "<leader>dO", "<cmd>lua require('dap').step_over()<CR>", { desc = "Step Over" })
map("n", "<leader>dj", "<cmd>lua require('dap').down()<CR>", { desc = "Down" })
map("n", "<leader>dk", "<cmd>lua require('dap').up()<CR>", { desc = "Up" })
map("n", "<leader>dp", "<cmd>lua require('dap').pause()<CR>", { desc = "Pause" })
map("n", "<leader>dc", "<cmd>lua require('dap').continue()<CR>", { desc = "Continue" })
map("n", "<leader>dl", "<cmd>lua require('dap').run_last()<CR>", { desc = "Run Last" })
map("n", "<leader>dC", "<cmd>lua require('dap').run_to_cursor()<CR>", { desc = "Run to Cursor" })
map("n", "<leader>dt", "<cmd>lua require('dap').terminate()<CR>", { desc = "Terminate" })
map("n", "<leader>ds", "<cmd>lua require('dap').session()<CR>", { desc = "Session" })
map("n", "<leader>dr", "<cmd>lua require('dap').repl.toggle()<CR>", { desc = "Toggle REPL" })
map("n", "<leader>dw", "<cmd>lua require('dap.ui.widgets').hover()<CR>", { desc = "Widgets" })

map("n", "<leader>dpr", function()
  require("dap-python").test_method()
end, { desc = "DAP Python Test Method" })


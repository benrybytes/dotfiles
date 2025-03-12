local dap = require "dap"
local dapui = require "dapui"

require("dap-python").setup("python3")

dapui.setup()

dap.adapters.codelldb = {
	type = 'server',
	port = "1337",
	executable = {
		command = "/Users/henrymartinez/Documents/codelldb/extension/adapter/codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"
		args = {"--port", "1337"},
	}
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch Main Script",
		program = "${file}",
		pythonPath = function()
			-- Run 'which python' but ensure it’s clean
			local handle = io.popen("which python | tr -d '\n'")
			if handle == nil then
				return
			end
			local result = handle:read("*a")
			handle:close()
			return result
		end,
	},
	{
		type = "python",
		request = "launch",
		name = "Run Tests",
		module = "pytest",   -- Using pytest directly instead of unittest
		args = { "tests/", "-s" }, -- pytest takes positional arguments
		pythonPath = function()
			local handle = io.popen("which python")
			if handle then
				local result = handle:read("*l")
				handle:close()
				return result or "python"
			end
			return "python"
		end,
		-- Check if the current file is in the 'tests/' directory
		condition = function()
			return string.match(vim.fn.expand("%:p"), "/tests/")
		end,
	},
}


dap.set_log_level('TRACE')
vim.fn.sign_define("DapBreakpoint", { text = "" })


dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end


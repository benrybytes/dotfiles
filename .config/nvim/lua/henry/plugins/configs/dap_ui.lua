local dap = require "dap"
local dapui = require "dapui"

dapui.setup()

-- Configure DAP adapter for cppdbg
dap.adapters.codelldb = {
  type = "server",
  host = "127.0.0.1", -- use ipv4 rather than localhost
  --port = "${port}",
  port = "13777",
  executable = {
    command = "codelldb",
    args = {
      "--port",
      "13777",
    },
  },
}

dap.configurations.cpp = {
    {
        name = 'launch codelldb',
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

    }
}


dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

local status, _ = pcall(require, "henry/plugins-setup")
if not status then
	print(status)
	return
end
require("henry.core.options")
require("henry.core.keymaps")
require("henry.plugins.config.catppuccin")
require("henry.core.colorscheme")
require("henry.core.config")
-- Open a Vite project
vim.cmd([[
  command! -nargs=1 Vite :lua vim.fn.termopen('yarn && yarn dev', { cwd = <f-args> })
]])

vim.g.rojo_exe = "/Users/owner/.aftman/bin/rojo"
-- Runs an automatic command to detect lua files as luau

-- Plugins
require("henry.plugins.comment")
require("henry.plugins.nvim-tree")
require("henry.plugins.lualine")
require("henry.plugins.telescope")
require("henry.plugins.nvim-cmp")
require("henry.plugins.lsp.mason")
require("henry.plugins.lsp.lspsaga")
require("henry.plugins.lsp.null-ls") -- Connect the servers and files of any kind

require("henry.plugins.autopairs")
require("henry.plugins.treesitter")
require("henry.plugins.gitsigns")
require("henry.plugins.random.discord")
require("henry.plugins.harpoon")

-- Golang configuraton
-- vim.g.go_fmt_command = "goimports" -- Use goimports for code formatting
-- vim.g.go_highlight_functions = 1 -- Highlight function calls
-- vim.g.go_highlight_methods = 1 -- Highlight method calls
-- vim.g.go_highlight_structs = 1 -- Highlight struct names
-- vim.g.go_highlight_interfaces = 1 -- Highlight interface names

-- require("henry.plugins.config.go")

require("henry.plugins.config.rust-tools")
-- require("henry.plugins.random.obsidian")
require("henry.plugins.random.markview")

-- import mason plugin safely | purpose is to enable lisp and other configuration with formatting, autocomplete with lisp
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

local lspconfig_settings = require("henry.plugins.lsp.lspconfig")

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"clangd",
		"ts_ls",
		"html",
		"cssls",
		"tailwindcss",
		"lua_ls",
		"emmet_ls",
		"gopls",
		"rust_analyzer",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"lua-language-server",
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

-- Handlers for LSP servers using mason with lspconfig file
local status, lspconfig = pcall(require, "lspconfig")

if not status then
	return print("Lsp config not working")
end

mason_lspconfig.setup_handlers({
	function(server_name)
		if server_name == "luau-lsp" then
			require("luau-lsp").setup()
		end
		local server_config = lspconfig_settings.servers_config[server_name]
		if server_config then
			server_config.capabilities = lspconfig_settings.capabilities
			server_config.on_attach = lspconfig_settings.on_attach

			lspconfig[server_name].setup(server_config)
		end
	end,
})

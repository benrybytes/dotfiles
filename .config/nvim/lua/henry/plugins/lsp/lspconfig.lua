local M = {}

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local keymap = vim.keymap

-- Function to set up keybinds and other configurations when LSP server is attached
M.on_attach = function(client, bufnr)
	local opts = {
		noremap = true,
		silent = true,
		buffer = bufnr,
	}

	client.server_capabilities.signatureHelpProvider = false

	-- Set keybinds
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

	-- Typescript specific keymaps
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>")
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>")
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>")
	end

	-- Auto format on save
if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
        buffer = bufnr,
        callback = function()
            -- Disable clangd's formatting temporarily
            client.server_capabilities.documentFormattingProvider = false
            
            -- Save the current cursor position
            local cur_pos = vim.api.nvim_win_get_cursor(0)

            -- Manually format the file with `gg=G` but prevent cursor jump
            vim.cmd('normal! gg=G')

            -- Restore cursor position
            vim.api.nvim_win_set_cursor(0, cur_pos)

            -- Re-enable clangd formatting after formatting is done
            client.server_capabilities.documentFormattingProvider = true
        end,
    })
end
end

-- Enable autocompletion
M.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Change diagnostic symbols in sign column
local signs = { Error = "", Warn = " ", Hint = "", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- LSP server configurations
M.servers_config = {
	["html"] = {
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		},
		capabilities = M.capabilities,
		on_attach = M.on_attach,

	},
	["rust_analyzer"] = {
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		},
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	},
	["asm_lsp"] = {
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	},
	["ts_ls"] = {
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	},
	["jsonls"] = {
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	},
	["jdtls"] = {
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	},
	["cssls"] = {
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	},
	["lua_ls"] = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim", "require" } },
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				telemetry = { enable = false },
				hint = { enabled = true },
			},
		},
		filetypes = { "lua" },
		capabilities = M.capabilities,
		on_attach = M.on_attach,
	},
	["clangd"] = {
		capabilities = M.capabilities,
		on_attach = function(client, bufnr)
			print("Clangd attached to buffer", bufnr)

			-- Disable clangd formatting
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false

			print("clangd document formatting disabled")

			-- Clear any formatting autocmds
			vim.api.nvim_clear_autocmds({ group = "LspFormatting" })

			-- Debug the active autocmds
			print("Active autocmds:")
			vim.cmd('autocmd')

			-- Custom formatting behavior
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
				buffer = bufnr,
				callback = function()
					print("Manual formatting triggered")
					vim.cmd('normal! gg=G')
				end,
			})
		end,
	},
	["luau-lsp"] = {

		capabilities = M.capabilities,
		on_attach = M.on_attach,
		settings = {
			platform = {
				type = "roblox",
			},
			sourcemap = {
				enabled = true,
				autogenerate = true,
				rojo_path = "rojo",
				rojo_project_file = "default.project.json",
				include_non_scripts = true,
			},
			types = {
				definition_files = {},
				documentation_files = {},
				roblox_security_level = "PluginSecurity",
			},
			fflags = {
				enable_by_default = false,
				sync = true,
				override = {},
			},
			plugin = {
				enabled = false,
				port = 3667,
			},
		},
		cmd = { "luau-lsp", "lsp" },
		filetypes = { "luau" },
	},
	["pylsp"] = {
		capabilities = M.capabilities,
		on_attach = M.on_attach,
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = { 'W391' },
						maxLineLength = 150
					}
				}
			}
		}
	},
}
return M

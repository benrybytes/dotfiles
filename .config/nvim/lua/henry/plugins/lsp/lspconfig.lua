-- Setup Mason and LSP servers
require("mason").setup()
local _, lspconfig = pcall(require, "lspconfig")

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
	print("could not load mason")
end

mason_lspconfig.setup({
	ensure_installed = {
		"html",
		"rust_analyzer",
		"asm_lsp",
		"jsonls",
		"jdtls",
		"cssls",
		"lua_ls",
		"clangd",
		"luau_lsp",
		"pylsp",
	},
	automatic_enable = {}
})

-- Blink CMP setup
local status, blink_cmp = pcall(require, 'blink.cmp')
if not status then
	print("could not load blink")
	return
end

local capabilities = blink_cmp.get_lsp_capabilities()

blink_cmp.setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	keymap = {
		['<C-k>'] = { 'select_prev', 'fallback' },
		['<C-j>'] = { 'select_next', 'fallback' },
		['<CR>']  = { 'select_and_accept', 'fallback' },
	},
	completion = {
		menu = { border = 'rounded', draw = { cursorline_priority = 0 } },
		documentation = { window = { border = 'rounded' }, auto_show = true },
		list = {
			selection = { preselect = true, auto_insert = true }
		},
		ghost_text = { enabled = true }
	},
	signature = { window = { border = 'rounded' } }
})

-- Diagnostic signs
local signs = { Error = "", Warn = " ", Hint = "", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- on_attach function
local function on_attach(_, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

	vim.api.nvim_create_autocmd("BufWritePre", {
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ async = true })
		end,
	})
end

-- LSP server configurations
local servers = {
	html = {
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		}
	},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				checkOnSave = true,
				check = { command = "clippy" },
				diagnostics = { enable = true, disabled = { "unreachable-code" } },
				cargo = { allFeatures = true, loadOutDirsFromCheck = true },
				procMacro = { enable = true },
			}
		}
	},
	asm_lsp = {},
	jsonls = {},
	jdtls = {},
	cssls = {},
	lua_ls = {
		settings = {
			Lua = {
				diagnostics = { globals = { "vim", "require" } },
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				telemetry = { enable = false },
				hint = { enabled = true },
			}
		},
		filetypes = { "lua" },
	},
	clangd = {},
	luau_lsp = {
		settings = {
			platform = { type = "roblox" },
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
	pylsp = {
		settings = {
			pylsp = {
				plugins = {
					pycodestyle = {
						ignore = { "W391" },
						maxLineLength = 150,
					}
				}
			}
		}
	}
}

for server_name, config in pairs(servers) do
	config.capabilities = config.capabilities or capabilities
	config.on_attach = config.on_attach or on_attach
	lspconfig[server_name].setup(config)
end

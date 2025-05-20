local M = {}

require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    },
})

-- symbolic link the "cargo build --release" directory as default packer install does not work
-- ln -s /Users/henrymartinez/.config/nvim/blink.cmp /Users/henrymartinez/.local/share/nvim/site/pack/packer/start/blink.cmp
local status, blink_cmp = pcall(require, 'blink.cmp')
if not status then
	print("could not load blink")
	return
end

local capabilities = blink_cmp.get_lsp_capabilities()
local lspconfig = require('lspconfig')

blink_cmp.setup({
	fuzzy = { implementation = "prefer_rust_with_warning" },
	keymap = {
		['<C-k>'] = { 'select_prev', 'fallback' },
		['<C-j>'] = { 'select_next', 'fallback' },
		['<CR>']  = { 'select_and_accept', 'fallback' },
	},
	completion = {
		menu = { border = 'rounded', draw = {
			cursorline_priority = 0
		} },
		documentation = { window = { border = 'rounded' }, auto_show = true},
		list = {
			selection = { preselect = true, auto_insert = true }
		},
		ghost_text = {
			enabled = true
		}
	},
	signature = { window = { border = 'rounded' }}
})

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
		capabilities,

	},
	["rust_analyzer"] = {
		init_options = {
			userLanguages = {
				eelixir = "html-eex",
				eruby = "erb",
				rust = "html",
			},
		},
		capabilities = capabilities,
	},
	["asm_lsp"] = {
		capabilities,
	},
	["ts_ls"] = {
		capabilities,
	},
	["jsonls"] = {
		capabilities,
	},
	["jdtls"] = {
		capabilities,
	},
	["cssls"] = {
		capabilities,
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
		capabilities
	},
	["clangd"] = {
		capabilities,
	},
	["luau_lsp"] = {

		capabilities,
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
		capabilities,
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

for server, config in pairs(M.servers_config) do
	lspconfig[server].setup(config)
end

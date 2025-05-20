--auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed


-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	print(status)
	return
end

vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
augroup end
]])

-- add list of plugins to install | To install, save first, then exit
return packer.startup(function(use)

	-- packer can manage itself
	use("wbthomason/packer.nvim")

	use {
		"williamboman/nvim-lsp-installer",
		"neovim/nvim-lspconfig",
	}

	-- Lua functions many plugins use
	use("nvim-lua/plenary.nvim")

	use {
		"julianolf/nvim-dap-lldb",
		dependencies = { "mfussenegger/nvim-dap" },
	}

	use { 'kdheepak/monochrome.nvim' }
	use({
		"lopi-py/luau-lsp.nvim",

		filetypes = { "luau" },
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})


	-- Color Schemes
	use({ "catppuccin/nvim", as = "catppuccin" })
	use {'rktjmp/lush.nvim'}
	use {
		"zenbones-theme/zenbones.nvim",
	}

	-- Split windows and navigation
	use("christoomey/vim-tmux-navigator")

	use 'mfussenegger/nvim-dap'
	use 'nvim-neotest/nvim-nio'
	use 'rcarriga/nvim-dap-ui'
	use("goolord/alpha-nvim")

	use("numToStr/Comment.nvim")
	use 'mfussenegger/nvim-dap-python'

	-- File explorer
	use("nvim-tree/nvim-tree.lua")
	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	})

	-- Discord presence
	use {
		'vyfor/cord.nvim',
		run = ':Cord update',
	}
	-- file explorer icons
	use("kyazdani42/nvim-web-devicons")

	-- Statusline to show what mode of nvim you are
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })        -- fuzzy finder

	use("onsails/lspkind.nvim")  -- vs-code like icons for autocompletion

	use({
		"jose-elias-alvarez/null-ls.nvim",
	})                                 -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	use {
		'windwp/nvim-ts-autotag',
		branch = 'main',
		requires = {
			'nvim-treesitter/nvim-treesitter',
		},
		config = function ()
			require('nvim-ts-autotag').setup()
		end
	}

	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- use 'simrat39/rust-tools.nvim'
	use("MunifTanjim/prettier.nvim")

	if packer_bootstrap then
		require("packer").sync()
		return
	end
end)

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

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
--vim.cmd([[
-- augroup packer_user_config
-- autocmd!
-- autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
-- augroup end
-- ]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end
-- add list of plugins to install | To install, save first, then exit
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	-- Discord presence
	use("andweeb/presence.nvim")

	-- Lua functions many plugins use
	use("nvim-lua/plenary.nvim")

	-- Luau with vim
	-- use("polychromatist/luau-vim")

	use({
		"lopi-py/luau-lsp.nvim",

		filetypes = { "luau" },
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- Color Schemes
	use("navarasu/onedark.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use("projekt0n/github-nvim-theme")

	-- Split windows and navigation
	use("christoomey/vim-tmux-navigator")

	use("szw/vim-maximizer") -- Maximises and restores current window

	use("goolord/alpha-nvim")

	-- Essential Plugins
	-- | Ex: Normal mode: ys -> g@w -> Character to wrap
	-- | Ex: Normal mode: ds -> Character surrounding to delete
	-- | Ex: Normal mode: cs -> Character to change -> character to replace to
	use("tpope/vim-surround")

	-- Copy Text and be able to replace to
	-- | Ex: yw to copy text -> grw the text to use the copied text on
	use("vim-scripts/ReplaceWithRegister")

	-- Need to Configure in plugins directory!

	use("numToStr/Comment.nvim")

	-- File explorer
	use("nvim-tree/nvim-tree.lua")

	-- Terminal popup
	use("voldikss/vim-floaterm")

	-- file explorer icons
	use("kyazdani42/nvim-web-devicons")

	-- Statusline to show what mode of nvim you are
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths
	use("hrsh7th/vim-vsnip")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-nvim-lsp-signature-help")
	use("hrsh7th/cmp-vsnip")
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use({
		"kkharji/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
		after = "nvim-treesitter",
	}) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
	use("tpope/vim-fugitive") -- Help simplify git with commits, add, push, etc

	-- Golang
	use("ray-x/go.nvim")
	use("fatih/vim-go")

	use({ "neoclide/coc.nvim", branch = "release", run = "yarn install --frozen-lockfile" }) -- Lsp helper
	use("dsznajder/vscode-es7-javascript-react-snippets") -- Optional: React snippets for coc.nvim
	-- Add other plugins as needed

	-- rust
	use("simrat39/rust-tools.nvim")

	use({
		"epwalsh/obsidian.nvim",
		tag = "*", -- recommended, use latest release instead of latest commit
		requires = {
			-- Required.
			"nvim-lua/plenary.nvim",

			-- see below for full list of optional dependencies 👇
		},
	})
	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use({
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		-- dependencies = {
		-- 	-- You will not need this if you installed the
		-- 	-- parsers manually
		-- 	-- Or if the parsers are in your $RUNTIMEPATH
		-- 	"nvim-treesitter/nvim-treesitter",
		--
		-- 	"nvim-tree/nvim-web-devicons",
		-- },
	})
	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = {
				"markdown",
			}
		end,
		ft = { "markdown" },
	})

	if packer_bootstrap then
		require("packer").sync()
		return
	end
end)

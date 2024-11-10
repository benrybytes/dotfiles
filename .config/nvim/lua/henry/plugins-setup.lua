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

    -- Discord presence
    use("andweeb/presence.nvim")

    -- Lua functions many plugins use
    use("nvim-lua/plenary.nvim")

    use {
        "julianolf/nvim-dap-lldb",
        dependencies = { "mfussenegger/nvim-dap" },
        opts = { codelldb_path = "/path/to/codelldb" },
    }
    use 'jay-babu/mason-nvim-dap.nvim'

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
    use({ "catppuccin/nvim", as = "catppuccin" })
    use({ "rose-pine/neovim", name = "rose-pine" })
    use("projekt0n/github-nvim-theme")

    -- Split windows and navigation
    use("christoomey/vim-tmux-navigator")

    use 'mfussenegger/nvim-dap'
    use 'nvim-neotest/nvim-nio'
    use 'rcarriga/nvim-dap-ui'

    use("szw/vim-maximizer") -- Maximises and restores current window

    use("goolord/alpha-nvim")

    use("numToStr/Comment.nvim")

    -- File explorer
    use("nvim-tree/nvim-tree.lua")

    -- file explorer icons
    use("kyazdani42/nvim-web-devicons")

    -- Statusline to show what mode of nvim you are
    use("nvim-lualine/lualine.nvim")

    -- fuzzy finding w/ telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })        -- fuzzy finder

    -- autocompletion
    use("hrsh7th/nvim-cmp")   -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path")   -- source for file system paths
    use("hrsh7th/vim-vsnip")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion

    -- snippets
    use("L3MON4D3/LuaSnip")         -- snippet engine
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion

    -- managing & installing lsp servers, linters & formatters
    use("williamboman/mason.nvim")           -- in charge of managing lsp servers, linters & formatters
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
    })                          -- enhanced lsp uis
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

    -- formatting & linting
    use({
        "jose-elias-alvarez/null-ls.nvim",
        opts = function()
            return require "henry.plugins.lsp.null-ls"
        end,
    })                                 -- configure formatters & linters
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
    use("tpope/vim-fugitive")      -- Help simplify git with commits, add, push, etc

    use({
        "neoclide/coc.nvim",
        branch = "release",
        run = "yarn install --frozen-lockfile",
        init = function()
            vim.g.coc_start_at_startup = 1
            vim.g.coc_config_home = 'lua/configurations/plugins/coc/'
            vim.g.coc_global_extensions = require("configurations.plugins.coc.coc_ensure_installed")
        end,
    }) -- Lsp helper
    use({
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } },
    })

    use({
        "OXY2DEV/markview.nvim",
        lazy = false, -- Recommended
    })

    use 'simrat39/rust-tools.nvim'


    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = {
                "markdown" }
        end,
        ft = { "markdown" },
    })
    use("MunifTanjim/prettier.nvim")

    if packer_bootstrap then
        require("packer").sync()
        return
    end
end)

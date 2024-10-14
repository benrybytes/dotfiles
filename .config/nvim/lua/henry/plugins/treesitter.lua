-- import nvim-treesitter plugin safely
-- Purpose: Used to be able to auto-close tags, quotes, brackets, etc
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- enable autotagging (w/ nvim-ts-autotag plugin)
	-- autotag = { enable = true },
	sync_install = false,
	modules = {},
	ignore_install = {},
	-- ensure these language parsers are installed
	ensure_installed = {
		"c",
		"json",
		"javascript",
		"typescript",
		"tsx",
		"yaml",
		"html",
		"css",
		"markdown",
		"markdown_inline",
		"svelte",
		"graphql",
		"bash",
		"lua",
		"vim",
		"dockerfile",
		"gitignore",
		"go",
		"gomod",
		"gosum",
		"gowork",
		"luau",
	},
	-- auto install above language parsers
	auto_install = true,
})

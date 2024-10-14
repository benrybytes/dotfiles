-- import null-ls plugin safely
-- Purpose: Middleman in connecting other plugins of other languages to vim's built-in server for LSP
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to set up formatters
local diagnostics = null_ls.builtins.diagnostics -- to set up linters

-- to set up format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
	-- setup formatters & linters
	sources = {
		-- to disable file types use "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
		formatting.prettier.with({}), -- js/ts formatter
		formatting.stylua.with({}), -- lua formatter
		diagnostics.eslint_d.with({
			-- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
			condition = function(utils)
				return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
			end,
		}), -- js/ts linter
	},
	-- configure format on save
	on_attach = function(current_client, bufnr)
		if current_client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(client)
							-- only use null-ls for formatting instead of LSP server
							return client.name == "null-ls"
						end,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})

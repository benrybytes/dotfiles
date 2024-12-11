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
    keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
    keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
    keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
    keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
    keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
    keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
    keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
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
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ async = true })
            end,
        })
    end
end

-- Enable autocompletion
M.capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Change diagnostic symbols in sign column
local signs = { Error = " ", Warn = " ", Hint = "●", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- Define the root directory function
local util = require("lspconfig.util")

-- LSP server configurations
M.servers_config = {
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
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        cmd = {
            "clangd",
            "--offset-encoding=utf-16",
        },
        capabilities = M.capabilities,
        on_attach = M.on_attach,
    },
    ["luau-lsp"] = {

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
        -- root_dir = get_root_dir,
        filetypes = { "luau" },
        capabilities = M.capabilities,
        on_attach = M.on_attach,
    },
    ["pylsp"] = {
        capabilities = M.capabilities,
        on_attach = M.on_attach,
    },
}
return M

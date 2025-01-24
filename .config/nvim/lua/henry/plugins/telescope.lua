-- import telescope plugin safely
-- Purpose: Be able to look for files in a GUI
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
    return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
    return
end

local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "gd", telescope_builtin.lsp_definitions, { noremap = true, silent = true })
vim.keymap.set("n", "gi", telescope_builtin.lsp_implementations, { noremap = true, silent = true })
vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { noremap = true, silent = true })
vim.keymap.set("n", "gT", telescope_builtin.lsp_type_definitions, { noremap = true, silent = true })


-- configure telescope
telescope.setup({
    -- configure Lsp mappings
    defaults = {
        -- Moving around the Telescope GUI
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,                       -- move to prev result
                ["<C-j>"] = actions.move_selection_next,                           -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            },
        },
        file_ignore_patterns = {
            "node_modules",
            "lib",
            "include",
            "__pycache__",
            ".idea",
            ".venv"
        }
    },
})

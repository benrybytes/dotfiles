local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED
local keymap = vim.keymap

keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)
keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

keymap.set("n", "<C-y>", function()
	harpoon:list():select(1)
end)
keymap.set("n", "<C-u>", function()
	harpoon:list():select(2)
end)
keymap.set("n", "<C-i>", function()
	harpoon:list():select(3)
end)
keymap.set("n", "<C-o>", function()
	harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
keymap.set("n", "<C-j>", function()
	harpoon:list():prev()
end)
keymap.set("n", "<C-k>", function()
	harpoon:list():next()
end)

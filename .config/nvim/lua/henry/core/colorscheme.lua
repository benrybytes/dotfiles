-- Set colorscheme to onedark.nvim with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme rose-pine") -- command colorscheme
if not status then
    print("Colorscheme not found!")
    return
end

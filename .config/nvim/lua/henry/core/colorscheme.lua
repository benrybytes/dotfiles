-- Set colorscheme to onedark.nvim with protected call
-- in case it isn't installed
local cmd = vim.cmd
local status, _ = pcall(cmd, "colorscheme rose-pine") -- command colorscheme
if not status then
    print("Colorscheme not found!")
    return
end

cmd("hi NonText guifg=bg")

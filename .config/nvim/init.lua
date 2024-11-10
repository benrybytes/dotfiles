local status, _ = pcall(require, "henry/plugins-setup")
if not status then
    return
end

-- Load plugins via file globbing
local function require_directories(directory_name, nested_path)
    local before_path = '~/.config/nvim/lua/henry/'
    local directory_path = before_path .. directory_name .. nested_path .. '/*lua'
    local paths = vim.split(vim.fn.glob(directory_path), '\n')

    for _, file in pairs(paths) do
        local file_path = string.gsub(
            string.sub(file, (string.find(file, 'henry/')) or 0, string.len(file) - 4),
            '/', '.')
        if string.len(file_path) == 0 then
            return
        end
        require(file_path)
    end
end

require_directories('colorschemes', '')
require_directories('core', '')
require_directories('plugins', '/*')
require_directories('plugins', '')

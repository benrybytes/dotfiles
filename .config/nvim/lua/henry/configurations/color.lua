local M = {}

-- Helper function to convert hex color to RGB
local function hex_to_rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)) / 255,
		tonumber("0x" .. hex:sub(3, 4)) / 255,
		tonumber("0x" .. hex:sub(5, 6)) / 255
end

-- Helper function to convert RGB to hex color
local function rgb_to_hex(r, g, b)
	return string.format("#%02X%02X%02X", math.floor(r * 255), math.floor(g * 255), math.floor(b * 255))
end

-- Function to darken a color
function M.darken(hex, percentage)
	local r, g, b = hex_to_rgb(hex)
	percentage = percentage / 100

	r = r * (1 - percentage)
	g = g * (1 - percentage)
	b = b * (1 - percentage)

	return rgb_to_hex(r, g, b)
end

return M

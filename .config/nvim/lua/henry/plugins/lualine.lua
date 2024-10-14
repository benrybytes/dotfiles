local status, lualine = pcall(require, "lualine")

if not status then
	return
end

local lualine_ayu_mirage = require("lualine.themes.ayu_mirage")

local new_colors = {
	blue = "#65D1FF",
	green = "#3EFFDC",
	violet = "#FF61EF",
	yellow = "#FFDA7B",
	black = "#000000",
}

lualine_ayu_mirage.normal.a.bg = new_colors.blue
lualine_ayu_mirage.insert.a.bg = new_colors.green
lualine_ayu_mirage.visual.a.bg = new_colors.violet
lualine_ayu_mirage.command = {
	a = {
		gui = "bold",
		bg = new_colors.yellow,
		fg = new_colors.black, -- black
	},
}

lualine.setup({
	options = {
		theme = lualine_ayu_mirage,
	},
})

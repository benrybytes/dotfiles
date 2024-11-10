local status, catppuccin = pcall(require, "catppuccin")

if not status then
	print(status)
	return status
end

print(catppuccin.setup())

require("catppuccin").setup({
	color_overrides = {
		all = {
			text = "#ffffff",
		},
		latte = {},
		frappe = {},
		macchiato = {},
		mocha = {

			base = "#101126",
			mantle = "#14151c",
			crust = "#14151c",
		},
	},
})

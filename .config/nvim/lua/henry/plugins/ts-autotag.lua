local status, autotag = pcall(require, "nvim-ts-autotag")

if not status then
	print("TS-autotag not loaded")
	return
end

autotag.setup({
	opts = {
		-- Defaults
		enable_close = true, -- Auto close tags
		enable_rename = true, -- Auto rename pairs of tags
		enable_close_on_slash = false, -- Auto close on trailing </
	},
})

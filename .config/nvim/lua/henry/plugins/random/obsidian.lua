local status, obsidian = pcall(require, "obsidian")
if not status then
	return
end

obsidian.setup({
	workspaces = {
		{
			name = "personal",
			path = "~/Documents/Notetaking/Notes",
		},
		{
			name = "work",
			path = "~/Documents/Notetaking/Coding Summaries",
		},
		{
			name = "cprogramming",
			path = "~/Documents/Notetaking/CProgramming",
		},
		{
			name = "math",
			path = "~/Documents/Notetaking/Math",
		},
	},
})

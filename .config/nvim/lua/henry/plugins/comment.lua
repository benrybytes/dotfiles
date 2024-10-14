-- Return comment variable and check the status
local setup, comment = pcall(require, "Comment")
if not setup then
	return
end

comment.setup()

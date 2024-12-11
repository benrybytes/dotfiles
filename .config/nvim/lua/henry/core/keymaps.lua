-- Lsp keybinds | don't interfere with vim keys
vim.g.mapleader = " "

local keymap = vim.keymap -- All keys

-- general

-- noraml mode to use space to increment and decrement number
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- Scroll inside hover documentation or definition preview
keymap.set("n", "<C-j>", "<cmd>Lspsaga hover_doc ++keep<CR>", opts)
keymap.set("n", "<C-k>", "<cmd>Lspsaga hover_doc ++keep<CR>", opts)


-- Breakpoints
keymap.set("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "breakpoint to line" })
keymap.set("n", "<leader>dr", "<cmd> DapContinue <CR>", { desc = "move to next breakpoint" })

-- Move chunks of lines when selected
keymap.set("v", "K", ":m '<-2<CR>gv=gv")
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("n", "J", "mzJ`z") -- Takes line below and append to current line

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })                 -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })               -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })                  -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>=", { desc = "Split Screens remove selected " }) -- make split windows equal width & heigh

-- Setup tab opening
keymap.set("n", "to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "tl", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "th", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- vim maximizer of window
keymap.set("n", "sm", ":MaximizerToggle<CR>")

-- nvim tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Paste word without it going to void directory
keymap.set("x", "<leader>p", '"_dP')

-- Better copy and paste by saving in global clipboard
keymap.set("n", "<leader>y", '"+y')
keymap.set("v", "<leader>y", '"+y')
keymap.set("n", "<leader>Y", '"+Y')

-- Switch projects with tmux
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Replace all word with command
keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r>C-w>/gI<Left><Left><Left>")
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")  -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")   -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>")     -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")   -- list available help tags

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>")   -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>")  -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>")    -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- Start the preview
keymap.set("n", "ms", ":MarkdownPreview<CR>") -- mapping to restart lsp if necessary

-- Stop the preview"
keymap.set("n", "mx", ":MarkdownPreviewStop<CR>") -- mapping to restart lsp if necessary

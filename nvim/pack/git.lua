-- GITBLAME
vim.pack.add({ "https://github.com/f-person/git-blame.nvim" })
vim.keymap.set("n", "<leader>gt", "<CMD>GitBlameToggle<CR>")
vim.keymap.set("n", "<leader>gs", "<CMD>GitBlameCopySHA<CR>")
vim.keymap.set("n", "<leader>gu", "<CMD>GitBlameCopyCommitURL<CR>")

-- GIT SINGS
vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
local gitsigns = require("gitsigns")
gitsigns.setup({
	attach_to_untracked = true,
	signs = {
		add = { text = "+" }, ---@diagnostic disable-line: missing-fields
		change = { text = "~" }, ---@diagnostic disable-line: missing-fields
		delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
		topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
		changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
	},
	-- gitsigns.nvim's recommended keymaps:
	on_attach = function(bufnr)
		-- Navigation
		-- vim.keymap.set("n", "]c", function()
		-- 	if vim.wo.diff then
		-- 		vim.cmd.normal({ "]c", bang = true })
		-- 	else
		-- 		gitsigns.nav_hunk("next")
		-- 	end
		-- end)

		-- vim.keymap.set("n", "[c", function()
		-- 	if vim.wo.diff then
		-- 		vim.cmd.normal({ "[c", bang = true })
		-- 	else
		-- 		gitsigns.nav_hunk("prev")
		-- 	end
		-- end)

		-- Visual mode actions
		-- vim.keymap.set("v", "<leader>hs", function()
		-- 	gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		-- end)
		--
		-- vim.keymap.set("v", "<leader>hr", function()
		-- 	gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		-- end)
		-- Normal mode actions
			vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, { buf = bufnr })

			vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, { buf = bufnr })

		-- vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer )
		--
		-- vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer )
			vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, { buf = bufnr })

			vim.keymap.set("n", "<leader>hi", gitsigns.preview_hunk_inline, { buf = bufnr })

		vim.keymap.set("n", "<leader>hb", function()
				gitsigns.blame_line({ full = true })
			end, { buf = bufnr })

			vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, { buf = bufnr })

		vim.keymap.set("n", "<leader>hD", function()
				gitsigns.diffthis("~")
			end, { buf = bufnr })

		vim.keymap.set("n", "<leader>hQ", function()
				gitsigns.setqflist("all")
			end, { buf = bufnr })

			vim.keymap.set("n", "<leader>hq", gitsigns.setqflist, { buf = bufnr })
		-- Toggles
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>tb",
		-- 	gitsigns.toggle_current_line_blame,
		-- 	{ desc = "[T]oggle git show [b]lame line", buf = bufnr }
		-- )
		-- vim.keymap.set(
		-- 	"n",
		-- 	"<leader>tw",
		-- 	gitsigns.toggle_word_diff,
		-- 	{ desc = "[T]oggle git intra-line [w]ord diff", buf = bufnr }
		-- )
		-- Text object
		-- vim.keymap.set({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "text object [i]nside [h]unk", buf = bufnr })
	end,
})

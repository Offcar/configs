vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
})
require("telescope").setup({
	pickers = {
		buffers = {
			sort_lastused = true,
			mappings = {
				n = { ["q"] = require("telescope.actions").delete_buffer },
			},
		},
	},
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})

-- Enable Telescope extensions if they are installed
pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

-- See `:help telescope.builtin`
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fk", builtin.keymaps)
vim.keymap.set("n", "<leader>ff", builtin.find_files)
-- vim.keymap.set('n', '<leader>fs', builtin.builtin )
vim.keymap.set("n", "<leader>fw", builtin.grep_string)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
vim.keymap.set("n", "<leader>fr", builtin.resume)
vim.keymap.set("n", "<leader>f.", builtin.oldfiles)
vim.keymap.set("n", "<leader>fc", builtin.commands)
vim.keymap.set("n", "<leader><leader>", builtin.buffers)

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
-- If you later switch picker plugins, this is where to update these mappings.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf

		-- Find references for the word under your cursor.
		vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "[G]oto [R]eferences" })

		-- Jump to the implementation of the word under your cursor.
		-- Useful when your language has ways of declaring types without an actual implementation.
		vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "[G]oto [I]mplementation" })

		-- Jump to the definition of the word under your cursor.
		-- This is where a variable was first declared, or where a function is defined, etc.
		-- To jump back, press <C-t>.
		vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "[G]oto [D]efinition" })

		-- Fuzzy find all the symbols in your current document.
		-- Symbols are things like variables, functions, types, etc.
		vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })

		-- Fuzzy find all the symbols in your current workspace.
		-- Similar to document symbols, except searches over your entire project.
		vim.keymap.set(
			"n",
			"gW",
			builtin.lsp_dynamic_workspace_symbols,
			{ buffer = buf, desc = "Open Workspace Symbols" }
		)

		-- Jump to the type of the word under your cursor.
		-- Useful when you're not sure what type a variable is and you want to see
		-- the definition of its *type*, not where it was *defined*.
		vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { buffer = buf, desc = "[G]oto [T]ype Definition" })
	end,
})

-- Override default behavior and theme when searching
-- vim.keymap.set('n', '<leader>/', function()
-- 	builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
-- 		winblend = 10,
-- 		previewer = false,
-- 	})
-- end)

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
-- vim.keymap.set("n", "<leader>s/", function()
-- 	builtin.live_grep({
-- 		grep_open_files = true,
-- 		prompt_title = "Live Grep in Open Files",
-- 	})
-- end)

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config"), follow = true })
end)

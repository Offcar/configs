vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.swapfile = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true
vim.opt.wrap = false
vim.o.laststatus = 3

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>")


local diagnostic_status = true -- Enabled por defecto
vim.keymap.set("n", "<leader>dt", function ()
	if diagnostic_status then
		vim.diagnostic.enable(false)
		diagnostic_status = false
	else
		vim.diagnostic.enable()
		diagnostic_status = true
	end
end)

vim.keymap.set("n", "<leader>dp", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist)

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>F", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- ---------------------------------------------------------------- Colorscheme
vim.pack.add({ { src = "https://github-com.translate.goog/rebelot/kanagawa.nvim" } })

-- ---------------------------------------------------------------- ZEN-MODE -> Center panel
vim.pack.add({ { src = "https://github.com/folke/zen-mode.nvim" } })
vim.keymap.set("n", "<leader>C", "<CMD>ZenMode<CR>")

-- ---------------------------------------------------------------- OIL -> File explorer
vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim" } })
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

-- ---------------------------------------------------------------- Guess-indent -> Tabs
vim.pack.add({ { src = "https://github.com/NMAC427/guess-indent.nvim" } })
require("guess-indent").setup({})

-- ---------------------------------------------------------------- Gitsings -> íconos para cambios git + git_blame
vim.pack.add({ { src = "https://github.com/lewis6991/gitsigns.nvim" } })
require("gitsigns").setup({})
vim.keymap.set("n", "gp", "<CMD>Gitsigns preview_hunk<CR>")
-- vim.keymap.set("n", "gt", "<CMD>Gitsigns toggle_current_line_blame<CR>")

-- ---------------------------------------------------------------- Telescope -> finders
vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	-- {src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"},
	-- {src = "https://github.com/nvim-telescope/telescope-ui-select.nvim"},
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		layout_strategy = "vertical",
	},
	pickers = {
		buffers = {
			sort_lastused = true,
			mappings = {
				n = { ["q"] = actions.delete_buffer },
			},
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)
vim.keymap.set("n", "<leader>fk", builtin.keymaps)
vim.keymap.set("n", "<leader>fn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end)

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

-- ---------------------------------------------------------------- AUTOCOMPLETE buenardo
vim.pack.add({
	{ src = "https://github.com/saghen/blink.lib" },
	{ src = "https://github.com/saghen/blink.cmp" },
})

require("blink.cmp").setup({
	completion = {
		menu = { auto_show = true },
	},
})

-- ---------------------------------------------------------------- LSP Plugins
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/j-hui/fidget.nvim" },
})
require("mason").setup()
require("fidget").setup()

local capabilities = require("blink.cmp").get_lsp_capabilities()

require("mason-lspconfig").setup({
	-- Aquí puedes poner los que quieres que se instalen SIEMPRE
	ensure_installed = { "lua_ls", "html", "gopls" },

	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({ capabilities = capabilities })
		end,

		["lua_ls"] = function()
			require("lspconfig").lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						format = { enable = false },
					},
				},
			})
		end,

		["gopls"] = function()
			require("lspconfig").gopls.setup({
				capabilities = capabilities,
				settings = {
					gopls = {
						staticcheck = true,
						hints = { parameterNames = true, rangeVariableTypes = true },
						analyses = { unusedparams = true, unreachable = true },
					},
				},
			})
		end,
	},
})



-- MINIBAR
vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-lualine/lualine.nvim",
})

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		always_show_tabline = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
			refresh_time = 16, -- ~60fps
			events = {
				"WinEnter",
				"BufEnter",
				"BufWritePost",
				"SessionLoadPost",
				"FileChangedShellPost",
				"VimResized",
				"Filetype",
				"CursorMoved",
				"CursorMovedI",
				"ModeChanged",
			},
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})

-- VIMWIKI - Configurado por MD
vim.pack.add({ "https://github.com/vimwiki/vimwiki" })
vim.g.vimwiki_markdown_link_ext = 1
vim.g.vimwiki_list = {
	{
		path = "~/vimwiki/",
		syntax = "markdown",
		ext = ".md",
	},
}

-- GITBLAME
vim.pack.add({'https://github.com/f-person/git-blame.nvim'})
vim.keymap.set("n", "gt", "<CMD>GitBlameToggle<CR>" )
vim.keymap.set("n", "gs", "<CMD>GitBlameCopySHA<CR>" )
vim.keymap.set("n", "gu", "<CMD>GitBlameCopyCommitURL<CR>" )


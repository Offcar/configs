-- OIL
vim.pack.add({ { src = "https://github.com/stevearc/oil.nvim" } })
require("oil").setup({
	view_options = {
		show_hidden = true,
	},
})
vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>")

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

-- TODO-COMMENTS - Notas coloreadas
vim.pack.add({ "https://github.com/folke/todo-comments.nvim" })
require("todo-comments").setup({ signs = false })

-- UNDOTREE - Arbol de cambios para hacer backtracking cuando la cago uwu
vim.pack.add({ "https://github.com/mbbill/undotree" })
vim.keymap.set("n", "<leader>u", "<CMD>UndotreeToggle<CR>")

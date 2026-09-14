vim.cmd.colorscheme("retrobox")

-- Arreglando carga de archivos
local config_dir = vim.fn.stdpath("config")
package.path = table.concat({
	config_dir .. "/?.lua",
	config_dir .. "/?/init.lua",
	package.path,
}, ";")

-- Opciones de nvim + keymaps
require("general.options")
require("general.keymaps")

-- Packages varios
require("pack.lsp")
require("pack.lualine")
require("pack.telescope")
require("pack.git")
require("pack.various")

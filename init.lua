---------------
--- Imports ---
---------------
require("options") -- Global options
require("keymaps") -- Keymaps
------------------
-- Lazy Install --
------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- Checking if it is installed
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- Importing plugins
require("lazy").setup("config") -- All plugin files are in the config folder

------------------
-- Plugins List --
------------------
-- Colorscheme: Catpuccin
-- Autocomplete: nvim-cmp (multiple packages used, explained in file)

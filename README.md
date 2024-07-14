# A guide to my configuration
Note: Many things from this version of my configuration have been taken by an amazing series of [tutorials](https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn) by typecraft.

First, we need to understand the filestructure.
The base folder is `~/.config/nvim` with the entirety of the neovim configuration residing here. The two files inside here are an `init.lua` file and a `lua` folder (containing all the other lua files, primarily the plugins.

Nvim
- Lua
  - Plugins
  - Plugins.lua
- init.lua

During the nvim runtime, neovim starts with the first init.lua file. Here, we give instructions on how to load everything and what to load (along with the order, which afaik lazyvim manages). 

Our package manager of choice is lazyvim. We begin by doing a generic installation of Lazy.

```lua
local lazypath = vim.fn.stdpath("data") .. "lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then 
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
```

Afterwards, we add `require("lazy").setup("plugins")` to import all the plugins from the plugins folder.
We can write all the plugins here but that makes it unnecessarily long and complex. Instead, we segment them into modules and lazyvim automatically builds those lua tables into one big plugins table at the end.

Next, we go to the `plugins.lua` file under the `lua` folder and add in
```lua
return {

}```

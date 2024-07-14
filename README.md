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

# A guide to my configuration
Note: Many things from this version of my configuration have been taken by an amazing series of [tutorials](https://www.youtube.com/watch?v=zHTeCSVAFNY&list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn) by typecraft.

First, we need to understand the filestructure.
The base folder is `~/.config/nvim` with the entirety of the neovim configuration residing here. The two files inside here are an `init.lua` file and a `lua` folder (containing all the other lua files, primarily the plugins.

Nvim
- Lua
  - Plugins
  - Plugins.lua
- init.lua

## The basics
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

Next, we go to the `plugins.lua` file under the `lua` folder and add in:
```lua
return {

}
```

This will return the plugin to the `setup` part we added and will auto(magically) build the table for us.

Some basic commands that are always useful to remember:
`:q!` - Quit neovim without saving
`:w` - Save file
`:wq` - Save and quit
`i` - Enter insert mode
`ESC` - Exit insert mode

## Plugins
Some common problem fixes:
- If you get some sort of nil value error right after copy pasting a package or editing a config, it's probably because you are missing a comma somehwere.

### Dracula
Now, we create a file within the plugins folder for our colorscheme. Personally, I've used dracula and aptly named my file `dracula.lua`. I'll go through the formatting of this one, but most of them are pretty much the same structure. I'll just talk about which packages and why I've used them.

Again, we use return to set up the table and import the package inside.
```lua
return  { 
    "Mofiqul/dracula.nvim", -- Importing the package
    priority = 1000 , -- Highest priority so nothing can override colorscheme 
  config = function() -- We can create configurations here
    vim.cmd([[colorscheme dracula]]) -- Setting the colorscheme as dracula
  end
  }
```

The basic structure is importing the file and configuring certain aspects of it. With specific packages like LSP, it can get a little more complex.

### Telescope
The most useful package in Vim by far. Nothing comes close to the pleasure of using a fuzzyfinder or grepping. 

`ctrl-t` can be used to fuzzy-find files.
`<space>fg` can be used to grep words (find word across all files).

An extension that I've downloaded is **telescope-ui-select** to make the telescope selection UI usable in LSP code actions.

### TreeSitter
Trying to explain it properly can be a huge deep dive. Essentially, it enables syntax highlighting in many ways.
One thing I've done that is sort of different from the generic configuration is turning `auto-install` to true, so it loads highlighting for any language that I haven't configured but have come across in my terminal ventures.

Note: Sometimes, you need to `:TSEnable highlight` after setup to see the highlights.

### Neo-Tree
Allows for a filesystem view in Vim. Brilliant stuff.

`Ctrl-n` to view the filesystem. Appears on the right.

If you want to change that, change the `vim.keymap.set('n', '<C-n>', ":Neotree filesystem reveal right<CR>")` right part at the end to a left.

### LuaLine
Makes the bottom bar in nvim look prettier.

### LSP
God, this was a nightmare. Probably doing a fresh config because I can't figure out how to properly set up the LSP and autocompletion in tandem with this one.

To manage our lsp, we use `mason.nvim`. On top of this, we use the extension `mason-lspconfig.nvim` to bridge `mason` with `lsp-config`.

`mason-lspconfig` is primarily used for the `ensure_installed` functionality that lets us make sure our LSP servers are installed before anything else, very useful. Instead of having to manually install LSP servers, we can automagically make sure they are installed. Great for fresh configs. 

After we install our LSP(s) through Mason's extension, we want to actually activate/set them up. For this, we use `lsp-config` where we do `lspconfig.LSPNAME.setup({})` for each LSP. I've added a bit more code to allow it to work with the linter and the auto-complete but it doesn't seemt to fit right. 

`Shift-K` - LSP Hover
`gd` - LSP Go To Definition
`<space>ca` - Code action. Code actions help us fix certain problems with our code that are highlighted by the LSP. 

### None-ls
This and the autocomplete, I don't fully understand myself.

`<space>gf` - Linter format

### Markdown Preview
Preview using `:MarkdownPreview`

return {
	{
		"williamboman/mason.nvim", -- LSP manager
		config = function()
			-- Configure Mason with custom UI icons
			require("mason").setup({
				ui = {
					icons = {
						package_installed = "✓", -- Icon for installed packages
						package_pending = "➜", -- Icon for packages being installed
						package_uninstalled = "✗", -- Icon for uninstalled packages
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim", -- Integrates Mason with LSP config, also automates LSP installation
		config = function()
			-- Ensure specific LSP servers are installed automatically
			require("mason-lspconfig").setup({
				ensure_installed = { "pylsp", "lua_ls", "rust_analyzer", "marksman", "tsserver", "html" }, -- List of LSP servers to install
			})
		end,
	},
	{
		"neovim/nvim-lspconfig", -- Configures LSPs for use
		config = function()
			-- Load the lspconfig module
			local lspconfig = require("lspconfig")

			-- Custom diagnostic keymaps
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts) -- Show diagnostics in a floating window
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- Go to the previous diagnostic
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- Go to the next diagnostic
			vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts) -- Set the location list with diagnostics

			-- Custom on_attach function to set keybindings after LSP attaches to a buffer
			local on_attach = function(client, bufnr)
				-- Enable completion triggered by <c-x><c-o>
				vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

				-- Buffer-specific keymaps for LSP-related actions
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- Go to declaration
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) -- Go to definition
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts) -- Hover information
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- Go to implementation
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts) -- Signature help
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts) -- Add workspace folder
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts) -- Remove workspace folder
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders())) -- List workspace folders
				end, bufopts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts) -- Go to type definition
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts) -- Rename symbol
				vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts) -- Code action
				vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts) -- List references
				vim.keymap.set("n", "<space>f", function()
					vim.lsp.buf.format({ async = true }) -- Format buffer
				end, bufopts)
			end

			-- Configure LSP servers
			lspconfig.pylsp.setup({
				on_attach = on_attach, -- Attach custom keybindings for Python LSP
			})
			lspconfig.lua_ls.setup({
				on_attach = on_attach, -- Attach custom keybindings for Lua LSP
			})
			lspconfig.rust_analyzer.setup({
				on_attach = on_attach, -- Attach custom keybindings for Rust LSP
			})
			lspconfig.marksman.setup({
				on_attach = on_attach, -- Attach custom keybindings for Markdown LSP
			})
			lspconfig.tsserver.setup({
				on_attach = on_attach, -- Attach custom keybindings for JS LSP
			})
		end,
	},
}

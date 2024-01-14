-- treesitter highlighting code, generates AST for parsers.
---- COMMAND :TSUpdate
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- Treesitter setup
		local config = require("nvim-treesitter.configs")
		config.setup({
			ensure_installed = {
				"lua",
				"javascript",
				"rust",
				"python",
				"c",
				"cpp",
				"html",
				"css",
				"toml",
				"yaml",
				"cmake",
				"fish",
				"gitignore",
				"go",
				"graphql",
				"http",
				"java",
				"scss",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}

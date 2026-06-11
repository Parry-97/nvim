vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/folke/flash.nvim",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
})

require("mini.basics").setup()
-- require("mini.jump2d").setup()
require("mini.git").setup()
require("flash").setup({
	modes = {
		search = {
			enabled = true, -- Enables flash labels during normal / or ? search
		},
	},
})
require("mini.diff").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
local colors = require("mini.colors")
colors.setup({})

-- Load miniwinter, strip the editor background, and apply it
colors.get_colorscheme("miniwinter"):add_transparency({ general = true, float = false }):apply()
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		-- Highlight hex color strings (`#rrggbb`) using that color
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

require("mini.tabline").setup()
require("mini.files").setup({
	mappings = {
		go_in = "<CR>",
		go_in_plus = "L",
		go_out = "_",
		go_out_plus = "H",
	},
})

vim.keymap.set("n", "<leader>e", function()
	local Minifiles = require("mini.files")
	Minifiles.open(vim.api.nvim_buf_get_name(0), false)
	Minifiles.reveal_cwd()
end, { desc = "Toggle into currently opened directory" })

local MiniPick = require("mini.pick")
MiniPick.setup()
vim.keymap.set("n", "<leader><leader>", function()
	MiniPick.builtin.files()
end, { desc = "Mini Pick Files" })

vim.keymap.set("n", "<leader>/", function()
	MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
end, { desc = "Mini Grep" })

vim.keymap.set("n", "<leader>bb", function()
	MiniPick.builtin.buffers()
end, { desc = "Mini Pick Buffers" })

vim.keymap.set("n", "<leader>vh", function()
	MiniPick.builtin.help()
end, { desc = "Mini Help" })

local MiniExtra = require("mini.extra")
MiniExtra.setup()
vim.keymap.set("n", "<leader>xx", function()
	MiniExtra.pickers.diagnostic()
end, { desc = "Mini Pick Diagnostics" })

vim.keymap.set("n", "<leader>ss", function()
	MiniExtra.pickers.lsp({ scope = "document_symbol" })
end, { desc = "Mini Pick Symbols" })

-- vim.keymap.set("n", "<leader>fb", function()
-- 	MiniExtra.pickers.registers()
-- end, { desc = "Mini Pick Registers" })

vim.keymap.set("n", "<leader>gf", function()
	MiniExtra.pickers.git_files()
end, { desc = "Mini Pick Git Files" })

vim.keymap.set("n", "grr", function()
	MiniExtra.pickers.lsp({ scope = "references" })
end, { desc = "Mini Pick References" })

vim.keymap.set("n", "gri", function()
	MiniExtra.pickers.lsp({ scope = "implementation" })
end, { desc = "Mini Pick Implementations" })

require("mini.completion").setup({
	lsp_completion = {
		auto_setup = true,
	},
})

--- mini snippets ---
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
	snippets = {
		MiniSnippets.gen_loader.from_lang(), -- loads friendly-snippets
	},
})
MiniSnippets.start_lsp_server({ match = false })

require("mini.surround").setup({
	mappings = {
		add = "gsa", -- Add surrounding
		delete = "gsd", -- Delete surrounding
		find = "gsf", -- Find surrounding
		find_left = "gsF", -- Find surrounding left
		highlight = "gsh", -- Highlight surrounding
		replace = "gsr", -- Replace surrounding
		update_n_lines = "gsn", -- Update 'n_lines'
	},
})
require("mason").setup()

require("mini.notify").setup({
	content = {
		format = function(notif)
			return notif.msg
		end,
	},
})

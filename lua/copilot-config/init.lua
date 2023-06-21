require("copilot").setup({
	panel = {
		enabled = true,
		auto_refresh = true,
		keymap = {
			jump_prev = "<c-j>",
			jump_next = "c-k",
			accept = "<c-a>",
			refresh = "r",
			open = "<M-CR>",
		},
		layout = {
			position = "bottom", -- | top | left | right
			ratio = 0.4,
		},
	},
	suggestion = {
		enabled = true,
		auto_trigger = false,
		debounce = 75,
		keymap = {
			accept = "<c-a>",
			accept_word = false,
			accept_line = false,
			next = "<c-j>",
			prev = "<c-k>",
			dismiss = "<C-e>",
		},
	},
	filetypes = {
		yaml = false,
		markdown = false,
		help = false,
		gitcommit = false,
		gitrebase = false,
		hgcommit = false,
		svn = false,
		cvs = false,
		["."] = false,
	},
	copilot_node_command = "node", -- Node.js version must be > 16.x
	server_opts_overrides = {},
})

require("copilot_cmp").setup()

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)

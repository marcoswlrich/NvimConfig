local glance = require("glance")
--local actions = glance.actions

glance.setup({
	border = {
		enable = false, -- Show window borders. Only horizontal borders allowed
		top_char = "―",
		bottom_char = "―",
	},
	list = {
		position = "right", -- Position of the list window 'left'|'right'
		width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
	},
	theme = { -- This feature might not work properly in nvim-0.7.2
		enable = true, -- Will generate colors for the plugin based on your current colorscheme
		mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
	},
	hooks = {},
	folds = {
		fold_closed = "",
		fold_open = "",
		folded = true, -- Automatically fold list on startup
	},
	indent_lines = {
		enable = true,
		icon = "│",
	},
	winbar = {
		enable = true, -- Available strating from nvim-0.8+
	},
})

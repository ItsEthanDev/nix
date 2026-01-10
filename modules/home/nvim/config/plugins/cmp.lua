return {
	{
		"saghen/blink.cmp",
		opts = {
			completion = {
				menu = {
					auto_show_delay_ms = 250,
				},
			},
			keymap = {
				preset = "default",
				["<CR>"] = {},
				["<C-y>"] = { "select_and_accept" },
			},
			sources = {
				default = { "lsp", "path", "snippets" },
			},
		},
	},
}

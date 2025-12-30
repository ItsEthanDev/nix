return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		picker = {
			sources = {
				explorer = {
					-- Hides the file explorer after a file has been selected
					auto_close = true,
				},
			},
		},
	},
}

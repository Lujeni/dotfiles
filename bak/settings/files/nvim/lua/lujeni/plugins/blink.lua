return {
	"saghen/blink.cmp",
	version = "1.*",
	opts = {
		keymap = {
			preset = "enter",
			["<C-space>"] = { "select_and_accept" },
		},
		appearance = {
			nerd_font_variant = "mono",
			use_nvim_cmp_as_default = true,
		},
		signature = {
			enabled = true,
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
					columns = { { "label", gap = 1 }, { "kind_icon", gap = 1, "kind" } },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
		},
		sources = {
			default = { "lazydev", "lsp", "buffer", "path" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}

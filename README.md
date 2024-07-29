# qfscope.nvim

quickfix + telescope = qfscope

Refine [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) search results by using quickfix list.

Typical use case is to refine search results of `:Telescope live_grep`:

- by filename, which cannot be done by `:Telescope live_grep`
- by text, which requires complex regex

Let's trigger `qfscope.nvim` actions and refine search results by fuzzy keywords or regex patterns.
`qfscope.nvim` also provides a simple history navigations.

## Demo

The left pane shows the descriptions, and the right pane shows the demo.

[](https://github.com/user-attachments/assets/5c073f15-9342-4269-8aa8-a7e7ec17ea99)

## Example setup

```lua
local qfs_actions = require("qfscope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-G><C-G>"] = qfs_actions.qfscope_search_filename,
				["<C-G><C-F>"] = qfs_actions.qfscope_grep_filename,
				["<C-G><C-L>"] = qfs_actions.qfscope_grep_line,
				["<C-G><C-T>"] = qfs_actions.qfscope_grep_text,
			},
		},
	},
})
```

# qfscope.nvim

quickfix + telescope = qfscope

Trigger `qfscope.nvim` actions and refine [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) search results by fuzzy keywords or regex patterns in quickfix list.
`qfscope.nvim` also provides a simple history navigations.

Typical use case is to refine search results of `:Telescope live_grep` like below.

- Refinements by fuzzy finding filename, which cannot be done by `live_grep`.
- Refinements by grepping `live_grep`-matched text, which may require if only using `live_grep`.

Of course, you can use `qfscope.nvim` with other telescope commands such as `marks`, `diagnostics`, `lsp_reference` and so on.

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

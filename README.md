# qfscope.nvim

Refine [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) search results.

Typical use case is to refine search results of `:Telescope live_grep`:

- by filename, which cannot be done by `:Telescope live_grep`
- by text, which requires complex regex

Let's trigger `qfscope.nvim` actions and refine search results by fuzzy keywords or regex patterns.
`qfscope.nvim` also provides a simple history navigations.

## Demo

<video width="800" controls>
  <source src="
https://github.com/user-attachments/assets/5c073f15-9342-4269-8aa8-a7e7ec17ea99" type="video/mp4">
</video>

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
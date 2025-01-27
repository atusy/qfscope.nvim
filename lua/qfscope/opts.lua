local M = {}

M.default = {
	pickers = {
		qfscope = {
			attach_mappings = function(prompt_bufnr, map)
				local actions = require("qfscope.actions")
				-- navigations
				map({ "i" }, "<C-Left>", function()
					actions.qfscope_open_previous(prompt_bufnr)
				end)
				map({ "i" }, "<C-Right>", function()
					actions.qfscope_open_next(prompt_bufnr)
				end)
				return true
			end,
		},
	},
}

M.user = vim.deepcopy(M.default)

return M

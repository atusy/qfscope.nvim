local M = {}

M.default = {
	pickers = {
		quickfix = {
			attach_mappings = function(prompt_bufnr, map)
				local actions = require("qfscope.actions")
				-- navigations
				map({ "i" }, "<C-Left>", function()
					actions.open_previous_quickfix(prompt_bufnr)
				end)
				map({ "i" }, "<C-Right>", function()
					actions.open_next_quickfix(prompt_bufnr)
				end)
				return true
			end,
		},
	},
}

M.user = setmetatable({}, {
	__index = function(_, key)
		return M.default[key]
	end,
})

return M

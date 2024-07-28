local M = {}

local state = require("qfscope._state")

--- Telescope quickfix picker with history navigation
function M.qfscope(opts)
	opts = vim.tbl_deep_extend("force", require("qfscope.opts").user, opts or {})

	local nth, id = (function()
		if type(opts.nth) == "number" and 1 <= opts.nth and opts.nth <= #state.record then
			return opts.nth, state.record[opts.nth]
		end
		local _id = opts.id or vim.fn.getqflist({ id = 0 }).id
		table.insert(state.record, _id)
		return #state.record, _id
	end)()

	state.nth = nth

	opts.id = id
	opts.nth = nil
	require("telescope.builtin").quickfix(opts)
end

return M

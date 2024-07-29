local M = {}

local state = require("qfscope._state")

local function configure(opts)
	local user = require("qfscope.opts").user
	local pickers = user.pickers or {}

	if type(opts.nth) == "number" and 1 <= opts.nth and opts.nth <= #state.record then
		local _opts = vim.tbl_deep_extend("force", state.record[opts.nth].opts, opts)
		_opts.nth = nil
		if not _opts.id then
			error("_state.record[" .. opts.nth .. "].opts.id is required")
		end
		return _opts, opts.nth
	end

	local _opts = vim.tbl_deep_extend("force", pickers.qfscope or {}, opts)
	_opts.id = _opts.id or vim.fn.getqflist({ id = 0 }).id
	return _opts, #state.record + 1
end

--- Telescope quickfix picker with history navigation
function M.qfscope(opts)
	local _opts, nth = configure(opts)

	if not state.record[nth] then
		state.record[nth] = { opts = _opts }
	end
	state.nth = nth

	require("telescope.builtin").quickfix(_opts)
end

return M

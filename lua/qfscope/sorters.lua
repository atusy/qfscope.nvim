local M = {}

---@param scope string|function|nil
---@return function(entry: table, line: string): string
local function get_scope(scope)
	local t = type(scope)

	if t == "function" then
		return scope
	end

	if t == "string" then
		if scope == "filename" then
			-- general usecase wants relative path
			return function(entry, _)
				return require("telescope.utils").transform_path({}, entry.filename)
			end
		end

		return function(entry, _)
			return entry[scope]
		end
	end

	return function(_, line)
		return line
	end
end

function M.get_scoped_search_sorter(opts)
	opts = opts or {}
	local sorter = opts.sorter or require("telescope.config").values.generic_sorter()
	local score = sorter.scoring_function
	local scope = get_scope(opts.scope)
	sorter.scoring_function = function(self, prompt, line, entry, ...)
		return score(self, prompt, scope(entry, line), entry, ...)
	end
	return sorter
end

function M.get_scoped_regex_sorter(opts)
	opts = opts or {}
	local sorter = opts.sorter or require("telescope.config").values.generic_sorter()
	local score_match = require("telescope.sorters").empty().scoring_function()
	local scope = get_scope(opts.scope)
	sorter.scoring_function = function(_, prompt, line, entry)
		if vim.regex(prompt):match_str(scope(entry, line)) then
			return score_match
		else
			return -1
		end
	end
	return sorter
end

return M

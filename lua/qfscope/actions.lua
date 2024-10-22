local actions = {
	-- navigations
	qfscope_open_previous = function(_)
		local state = require("qfscope._state")
		if state.nth > 1 then
			require("qfscope.pickers").qfscope({ nth = state.nth - 1 })
		end
	end,
	qfscope_open_next = function(_)
		local state = require("qfscope._state")
		if state.nth < #state.record then
			require("qfscope.pickers").qfscope({ nth = state.nth + 1 })
		end
	end,
}

for _, scope in pairs({
	"filename",
	"line",
	"text",
}) do
	actions["qfscope_search_" .. scope] = function(prompt_bufnr)
		require("telescope.actions").send_to_qflist(prompt_bufnr)
		require("qfscope.pickers").qfscope({
			sorter = require("qfscope.sorters").get_scoped_search_sorter({ scope = scope }),
			prompt_title = "Qfscope search " .. scope,
		})
	end
	actions["qfscope_grep_" .. scope] = function(prompt_bufnr)
		require("telescope.actions").send_to_qflist(prompt_bufnr)
		require("qfscope.pickers").qfscope({
			sorter = require("qfscope.sorters").get_scoped_regex_sorter({ scope = scope }),
			prompt_title = "Qfscope grep " .. scope,
		})
	end
end

---@class QfscopeActions : table<string, function(prompt_bufnr: number)>
---@field qfscope_open_previous function(prompt_bufnr: number)
---@field qfscope_open_next function(prompt_bufnr: number)
---@field qfscope_search_filename function(prompt_bufnr: number)
---@field qfscope_search_line function(prompt_bufnr: number)
---@field qfscope_search_text function(prompt_bufnr: number)
---@field qfscope_grep_filename function(prompt_bufnr: number)
---@field qfscope_grep_line function(prompt_bufnr: number)
---@field qfscope_grep_text function(prompt_bufnr: number)
return require("telescope.actions.mt").transform_mod(actions)

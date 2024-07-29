local function update_qfhistory(prompt_bufnr)
	local prompt = require("telescope.actions.state").get_current_picker(prompt_bufnr):_get_prompt()
	if prompt == "" then
		return
	end

	local state = require("qfscope._state")
	for i = state.nth, #state.record do
		state.record[i + 1] = nil
	end
	require("telescope.actions").send_to_qflist(prompt_bufnr)
	state.nth = #state.record + 1
	state.record[state.nth] = vim.fn.getqflist({ id = 0 }).id
end

local actions = {
	-- navigations
	open_previous_qfscope = function(prompt_bufnr)
		update_qfhistory(prompt_bufnr)
		local state = require("qfscope._state")
		if state.nth > 1 then
			require("qfscope.pickers").qfscope(state.record[state.nth - 1].opts)
		end
	end,
	open_next_qfscope = function(prompt_bufnr)
		update_qfhistory(prompt_bufnr)
		local state = require("qfscope._state")
		if state.nth < #state.record then
			require("qfscope.pickers").qfscope(state.record[state.nth + 1].opts)
		end
	end,
}

for _, target in pairs({
	"filename",
	"line",
	"text",
}) do
	actions["qfscope_search_" .. target] = function(prompt_bufnr)
		require("telescope.actions").send_to_qflist(prompt_bufnr)
		require("qfscope.pickers").qfscope({
			sorter = require("qfscope.sorters").get_scoped_sorter({ target = target }),
		})
	end
	actions["qfscope_grep_" .. target] = function(prompt_bufnr)
		require("telescope.actions").send_to_qflist(prompt_bufnr)
		require("qfscope.pickers").qfscope({
			sorter = require("qfscope.sorters").get_scoped_regex_sorter({ target = target }),
		})
	end
end

---@class QfscopeActions : table<string, function(prompt_bufnr: number)>
---@field open_previous_qfscope function(prompt_bufnr: number)
---@field open_next_qfscope function(prompt_bufnr: number)
---@field qfscope_search_filename function(prompt_bufnr: number)
---@field qfscope_search_line function(prompt_bufnr: number)
---@field qfscope_search_text function(prompt_bufnr: number)
---@field qfscope_grep_filename function(prompt_bufnr: number)
---@field qfscope_grep_line function(prompt_bufnr: number)
---@field qfscope_grep_text function(prompt_bufnr: number)
return require("telescope.actions.mt").transform_mod(actions)

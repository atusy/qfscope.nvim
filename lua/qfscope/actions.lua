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
	open_previous_quickfix = function(prompt_bufnr)
		update_qfhistory(prompt_bufnr)
		if require("qfscope._state").nth > 1 then
			-- FIXME: opts should be reproduced (e.g., sorter)
			require("qfscope.pickers").quickfix({ nth = require("qfscope._state").nth - 1 })
		end
	end,
	open_next_quickfix = function(prompt_bufnr)
		update_qfhistory(prompt_bufnr)
		if require("qfscope._state").nth < #require("qfscope._state").record then
			-- FIXME: opts should be reproduced (e.g., sorter)
			require("qfscope.pickers").quickfix({ nth = require("qfscope._state").nth + 1 })
		end
	end,
}

for _, target in pairs({
	"filename",
	"line",
	"text",
}) do
	actions["search_" .. target .. "_in_qf"] = function(prompt_bufnr)
		require("telescope.actions").send_to_qflist(prompt_bufnr)
		require("qfscope.pickers").quickfix({
			sorter = require("qfscope.sorters").get_scoped_sorter({ target = target }),
		})
	end
	actions["grep_" .. target .. "_in_qf"] = function(prompt_bufnr)
		require("telescope.actions").send_to_qflist(prompt_bufnr)
		require("qfscope.pickers").quickfix({
			sorter = require("qfscope.sorters").get_scoped_regex_sorter({ target = target }),
		})
	end
end

---@class QfscopeActions : table<string, function(prompt_bufnr: number)>
---@field open_previous_quickfix function(prompt_bufnr: number)
---@field open_next_quickfix function(prompt_bufnr: number)
---@field search_filename_in_qf function(prompt_bufnr: number)
---@field search_line_in_qf function(prompt_bufnr: number)
---@field search_text_in_qf function(prompt_bufnr: number)
---@field grep_filename_in_qf function(prompt_bufnr: number)
---@field grep_line_in_qf function(prompt_bufnr: number)
---@field grep_text_in_qf function(prompt_bufnr: number)
return require("telescope.actions.mt").transform_mod(actions)
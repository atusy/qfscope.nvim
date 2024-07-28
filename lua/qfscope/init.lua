return {
	setup = function(opts)
		require("qfscope.opts").user = vim.tbl_deep_extend("force", require("qfscope.opts").default, opts or {})
	end,
}

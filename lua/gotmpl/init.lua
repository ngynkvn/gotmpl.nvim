local M = {}

M.setup = function()
	vim.treesitter.query.add_directive("inject-go-tmpl!", function(_, _, bufnr, _, metadata)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local ft = vim.filetype.match({ filename = fname })
		if not ft then
			return
		end
		metadata["injection.language"] = ft
	end, {})

	-- Make sure vim recognizes .tmpl files as gotmpl ft
	vim.filetype.add({
		extension = {
			tmpl = "gotmpl",
		},
	})

	-- Moved query inline
	vim.treesitter.query.set(
		"gotmpl",
		"injections",
		[[
			((text) @injection.content
				(#inject-go-tmpl!)
				(#set! injection.combined))
		]]
	)
end

return M

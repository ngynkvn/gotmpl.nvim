local M = {}

M.setup = function()
	vim.treesitter.query.add_directive("inject-go-tmpl!", function(_, _, bufnr, _, metadata)
		local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
		local _, _, ext, _ = string.find(fname, ".*%.([^.]+)(%.%a+)")
		if ext then
			metadata["injection.language"] = ext
		end
	end, {})
	-- Make sure vim recognizes .tmpl files as gotmpl ft
	vim.filetype.add({
		extension = {
			tmpl = "gotmpl",
		},
	})
  vim.api.nvim_create_autocmd("FileType", {
		pattern = "gotmpl",
		callback = function()
			vim.treesitter.start()
		end,
	})
end

return M

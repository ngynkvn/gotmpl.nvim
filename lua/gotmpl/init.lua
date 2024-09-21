local M = {}

local DEFAULT_INJECTION = [[
((text) @injection.content
  (#inject-go-tmpl!)
  (#set! injection.combined))
]]

M.setup = function()
	vim.treesitter.query.add_directive("inject-go-tmpl!", function(_, _, bufnr, _, metadata)
		local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
		local _, _, ext, _ = string.find(fname, ".*%.(%a+)(%.%a+)")
		if ext then
			metadata["injection.language"] = ext
		end
	end, {})
	-- Setup injection for gotmpl filetypes
	vim.treesitter.query.set("gotmpl", "injections", DEFAULT_INJECTION)
	-- Make sure vim recognizes .tmpl files as gotmpl ft
	vim.filetype.add({
		extension = {
			tmpl = "gotmpl",
		},
	})
end

return M

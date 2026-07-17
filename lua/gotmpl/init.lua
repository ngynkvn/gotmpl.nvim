local M = {}

--- Resolves the host language for a `*.$FT.tmpl` buffer.
--- Exposed (and prefixed with `_`) so it can be exercised directly from tests
--- without needing a compiled `gotmpl` treesitter parser.
--- @param bufnr integer
--- @return string|nil
function M._detect_language(bufnr)
	local fname = vim.fs.basename(vim.api.nvim_buf_get_name(bufnr))
	-- Strip the trailing `.tmpl` before matching, otherwise this recognizes
	-- its own `tmpl -> gotmpl` filetype mapping instead of the host language.
	local stripped = vim.fn.fnamemodify(fname, ":r")
	return vim.filetype.match({ filename = stripped, buf = bufnr })
end

M.setup = function()
	vim.treesitter.query.add_directive("inject-go-tmpl!", function(_, _, bufnr, _, metadata)
		local lang = M._detect_language(bufnr)
		if lang then
			metadata["injection.language"] = lang
		end
	end, {})

	-- Make sure vim recognizes .tmpl files as gotmpl ft
	vim.filetype.add({
		extension = {
			tmpl = "gotmpl",
		},
	})

	-- Automatically enable Treesitter highlighting for gotmpl buffers. Guarded
	-- with pcall since this errors out if the `gotmpl` parser isn't installed
	-- (`:TSInstall gotmpl`), and we'd rather no-op than break every .tmpl file.
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "gotmpl",
		callback = function(args)
			pcall(vim.treesitter.start, args.buf)
		end,
	})
end

return M

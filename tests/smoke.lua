-- Minimal regression smoke test, run headless with no plugin manager:
--   nvim --headless -u NONE -l tests/smoke.lua
--
-- This exists because both open community PRs against this repo changed the
-- extension/filetype detection logic, and it's easy to get subtly wrong (e.g.
-- matching the buffer's own `.tmpl` extension instead of the host language
-- underneath it). Run this before merging any change to that logic.

vim.opt.runtimepath:append(vim.fn.getcwd())
local gotmpl = require("gotmpl")
gotmpl.setup()

local failures = 0

local function check(desc, got, want)
	if got ~= want then
		failures = failures + 1
		print(string.format("FAIL: %s (want=%s got=%s)", desc, vim.inspect(want), vim.inspect(got)))
	else
		print(string.format("ok:   %s", desc))
	end
end

-- `tmpl` extension itself is registered as the `gotmpl` filetype.
check("tmpl extension registers as gotmpl", vim.filetype.match({ filename = "plain.tmpl" }), "gotmpl")

-- Host-language detection for `*.$FT.tmpl` buffers, exercised via the
-- directive's underlying helper (avoids needing a compiled treesitter parser
-- for `gotmpl` just to run this test).
local cases = {
	{ name = "values.yaml.tmpl", content = "foo: {{ .Bar }}", want = "yaml" },
	{ name = "index.html.tmpl", content = "<html>{{ .Foo }}</html>", want = "html" },
	{ name = "configmap.json.tmpl", content = '{"a": "{{ .B }}"}', want = "json" },
	{ name = "query.sql.tmpl", content = "select {{ .Col }} from t", want = "sql" },
	{ name = "values-1.yaml.tmpl", content = "foo: {{ .Bar }}", want = "yaml" },
	-- No inner language to detect: should resolve to nil, not error or self-match.
	{ name = "plain.tmpl", content = "hello {{ .World }}", want = nil },
}

for _, c in ipairs(cases) do
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_name(buf, c.name)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, { c.content })
	check(c.name, gotmpl._detect_language(buf), c.want)
end

if failures > 0 then
	print(string.format("\n%d check(s) failed", failures))
	os.exit(1)
end
print("\nall checks passed")

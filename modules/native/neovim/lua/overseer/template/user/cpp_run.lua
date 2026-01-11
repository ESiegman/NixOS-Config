return {
	name = "run cpp binary",
	builder = function()
		local file_no_ext = vim.fn.expand("%:p:r")

		if vim.fn.filereadable(file_no_ext) == 0 then
			vim.notify("Binary not found. Compile first!", vim.log.levels.WARN)
			return nil
		end

		return {
			cmd = { file_no_ext },
			components = { "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}

return {
	name = "Python: Run File",
	builder = function()
		local file = vim.fn.expand("%:p")
		local python = (vim.env.VIRTUAL_ENV and vim.env.VIRTUAL_ENV .. "/bin/python") or "python3"
		return {
			cmd = { python },
			args = { file },
			components = { "default" },
		}
	end,
	condition = { filetype = { "python" } },
}

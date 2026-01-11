return {
	name = "g++ build",
	builder = function()
		local file = vim.fn.expand("%:p")
		local file_no_ext = vim.fn.expand("%:p:r")
		return {
			cmd = { "g++" },
			args = { "-g", "-std=c++23", "-Wall", "-Wextra", file, "-o", file_no_ext },
			components = { "default" },
		}
	end,
	condition = {
		filetype = { "cpp" },
	},
}

return {
	name = "Build and Run C++",
	builder = function()
		local file = vim.fn.expand("%:p")
		local file_no_ext = vim.fn.expand("%:p:r")
		return {
			cmd = { "sh", "-c" },
			args = {
				string.format("g++ -g -std=c++23 -Wall %s -o %s && %s", file, file_no_ext, file_no_ext),
			},
			components = {
				{ "on_output_summarize", max_lines = 10 },
				"on_exit_set_status",
				"on_complete_dispose",
				"default",
			},
		}
	end,
	condition = { filetype = { "cpp" } },
}

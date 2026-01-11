return {
	{
		"Civitasv/cmake-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			cmake_regenerate_on_save = false,
			cmake_notifications = true,
			cmake_build_options = {
				"-j8",
			},
			cmake_quick_commands_lualine_status = false,
			cmake_executable = "cmake",
		},
		keys = {
			{ "<leader>bc", "<cmd>CMakeConfigure<cr>", desc = "CMake: Configure" },
			{ "<leader>bb", "<cmd>CMakeBuild<cr>", desc = "CMake: Build" },
			{ "<leader>br", "<cmd>CMakeRun<cr>", desc = "CMake: Run Executable" },
			{ "<leader>bt", "<cmd>CMakeTest<cr>", desc = "CMake: Run Tests (CTest)" },
			{ "<leader>bB", "<cmd>CMakeClean<cr>", desc = "CMake: Clean Build" },
			{ "<leader>bv", "<cmd>CMakeView<cr>", desc = "CMake: View Target/Preset" },
		},
	},
}

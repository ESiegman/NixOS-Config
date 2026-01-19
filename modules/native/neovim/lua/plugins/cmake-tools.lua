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
			{ "<leader>lc", "<cmd>CMakeConfigure<cr>", desc = "CMake: Configure" },
			{ "<leader>lb", "<cmd>CMakeBuild<cr>", desc = "CMake: Build" },
			{ "<leader>lr", "<cmd>CMakeRun<cr>", desc = "CMake: Run Executable" },
			{ "<leader>lt", "<cmd>CMakeTest<cr>", desc = "CMake: Run Tests (CTest)" },
			{ "<leader>lB", "<cmd>CMakeClean<cr>", desc = "CMake: Clean Build" },
			{ "<leader>lv", "<cmd>CMakeView<cr>", desc = "CMake: View Target/Preset" },
		},
	},
}

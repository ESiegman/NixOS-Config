local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-------------------------------------------------------------------
-- Static C++ Snippets (LLVM-style)
-------------------------------------------------------------------
ls.add_snippets("cpp", {

	-- Simple function
	s(
		"fn",
		fmt(
			[[
{} {}({}) {{
  {}
}}
]],
			{
				i(1, "void"),
				i(2, "functionName"),
				i(3, "/* args */"),
				i(0),
			}
		)
	),

	-- LLVM-style class skeleton
	s(
		"cls",
		fmt(
			[[
class {} {{
public:
  {}({}); 
  ~{}(); 

private:
  {}
}};
]],
			{
				i(1, "MyClass"),
				rep(1),
				i(2, ""),
				rep(1),
				i(0),
			}
		)
	),

	-- Struct
	s(
		"struct",
		fmt(
			[[
struct {} {{
  {}
}};
]],
			{
				i(1, "MyStruct"),
				i(0),
			}
		)
	),

	-- Namespace
	s(
		"ns",
		fmt(
			[[
namespace {} {{

{}

}} // namespace {}
]],
			{
				i(1, "myNamespace"),
				i(0),
				rep(1),
			}
		)
	),

	-- Lambda
	s(
		"lam",
		fmt(
			[[
[{}]({} {}) {{
  {}
}};
]],
			{
				i(1, "&"),
				i(2, "auto&&"),
				i(3, "item"),
				i(0),
			}
		)
	),

	-- Template
	s("tem", fmt("template <typename {}>\n", { i(1, "T") })),

	-- Template class
	s(
		"temcls",
		fmt(
			[[
template <typename {}>
class {} {{
public:
  {}({});
  {}

private:
  {}
}};
]],
			{
				i(1, "T"),
				i(2, "MyClass"),
				rep(2),
				i(3, ""),
				i(4),
				i(0),
			}
		)
	),

	-- For loop
	s(
		"for",
		fmt(
			[[
for ({} {} = {}; {} < {}; {}++) {{
  {}
}}
]],
			{
				i(1, "size_t"),
				i(2, "i"),
				i(3, "0"),
				rep(2),
				i(4, "n"),
				rep(2),
				i(0),
			}
		)
	),

	-- Range-based for loop
	s(
		"forr",
		fmt(
			[[
for ({}& {} : {}) {{
  {}
}}
]],
			{
				i(1, "auto"),
				i(2, "item"),
				i(3, "container"),
				i(0),
			}
		)
	),

	-- Const range-based for loop
	s(
		"forc",
		fmt(
			[[
for (const {}& {} : {}) {{
  {}
}}
]],
			{
				i(1, "auto"),
				i(2, "item"),
				i(3, "container"),
				i(0),
			}
		)
	),

	-- Map iteration with structured binding
	s(
		"mapit",
		fmt(
			[[
for (const auto& [{}, {}] : {}) {{
  {}
}}
]],
			{
				i(1, "key"),
				i(2, "val"),
				i(3, "container"),
				i(0),
			}
		)
	),

	-- While loop
	s(
		"while",
		fmt(
			[[
while ({}) {{
  {}
}}
]],
			{
				i(1, "condition"),
				i(0),
			}
		)
	),

	-- If statement
	s(
		"if",
		fmt(
			[[
if ({}) {{
  {}
}}
]],
			{
				i(1, "condition"),
				i(0),
			}
		)
	),

	-- If-else
	s(
		"ife",
		fmt(
			[[
if ({}) {{
  {}
}} else {{
  {}
}}
]],
			{
				i(1, "condition"),
				i(2),
				i(0),
			}
		)
	),

	-- Switch statement
	s(
		"switch",
		fmt(
			[[
switch ({}) {{
  case {}:
    {}
    break;
  default:
    {}
    break;
}}
]],
			{
				i(1, "var"),
				i(2, "value"),
				i(3),
				i(0),
			}
		)
	),

	-- Enum
	s(
		"enum",
		fmt(
			[[
enum {} {{
  {}
}};
]],
			{
				i(1, "MyEnum"),
				i(0),
			}
		)
	),

	-- Enum class
	s(
		"enumc",
		fmt(
			[[
enum class {} {{
  {}
}};
]],
			{
				i(1, "MyEnum"),
				i(0),
			}
		)
	),

	-- Vector declaration
	s("vec", fmt("std::vector<{}> {}{};\n", { i(1, "int"), i(2, "vec"), i(3) })),

	-- Map declaration
	s("map", fmt("std::map<{}, {}> {};\n", { i(1, "Key"), i(2, "Value"), i(3, "map") })),

	-- Unordered map
	s("umap", fmt("std::unordered_map<{}, {}> {};\n", { i(1, "Key"), i(2, "Value"), i(3, "map") })),

	-- Set declaration
	s("set", fmt("std::set<{}> {};\n", { i(1, "int"), i(2, "set") })),

	-- Unique pointer
	s("uptr", fmt("std::unique_ptr<{}> {} = std::make_unique<{}>({});\n", { i(1, "Type"), i(2, "ptr"), rep(1), i(3) })),

	-- Shared pointer
	s("sptr", fmt("std::shared_ptr<{}> {} = std::make_shared<{}>({});\n", { i(1, "Type"), i(2, "ptr"), rep(1), i(3) })),

	-- Cout
	s("cout", fmt([[std::cout << {} << '\n';]], { i(1, "var") })),

	-- Cerr
	s("cerr", fmt([[std::cerr << {} << '\n';]], { i(1, "var") })),

	-- C++23 println
	s("pl", fmt([[std::println("{}", {});]], { i(1, "{}"), i(2, "var") })),

	-- Include guard
	s(
		"guard",
		fmt(
			[[
#ifndef {}
#define {}

{}
#endif // {}
]],
			{
				i(1, "MY_HEADER_H"),
				rep(1),
				i(0),
				rep(1),
			}
		)
	),

	-- Pragma once
	s("once", t("#pragma once\n")),

	-- Include
	s("inc", fmt("#include <{}>\n", { i(1, "iostream") })),

	-- Include local
	s("incl", fmt('#include "{}"\n', { i(1, "header.h") })),

	-- main function
	s(
		"main",
		fmt(
			[[
int main() {{
  {}
  return 0;
}}
]],
			{ i(0) }
		)
	),

	-- main with args
	s(
		"mainargs",
		fmt(
			[[
int main(int argc, char* argv[]) {{
  std::vector<std::string> args(argv + 1, argv + argc);
  {}
  return 0;
}}
]],
			{ i(0) }
		)
	),

	-- try/catch
	s(
		"try",
		fmt(
			[[
try {{
  {}
}} catch (const std::exception &e) {{
  std::cerr << "Error: " << e.what() << '\n';
}}
]],
			{ i(0) }
		)
	),

	-- Static cast
	s("scast", fmt("static_cast<{}>({})", { i(1, "Type"), i(2, "value") })),

	-- Dynamic cast
	s("dcast", fmt("dynamic_cast<{}>({})", { i(1, "Type"), i(2, "value") })),

	-- Const cast
	s("ccast", fmt("const_cast<{}>({})", { i(1, "Type"), i(2, "value") })),

	-- Reinterpret cast
	s("rcast", fmt("reinterpret_cast<{}>({})", { i(1, "Type"), i(2, "value") })),

	-- Assert
	s("assert", fmt("assert({});\n", { i(1, "condition") })),

	-- Static assert
	s("sassert", fmt('static_assert({}, "{}");\n', { i(1, "condition"), i(2, "message") })),

	-- Typedef
	s("typedef", fmt("typedef {} {};\n", { i(1, "Type"), i(2, "Alias") })),

	-- Using alias
	s("using", fmt("using {} = {};\n", { i(1, "Alias"), i(2, "Type") })),

	-- Function with Doxygen
	s(
		"fnd",
		fmt(
			[[
/// @brief {}
/// @param {} {}
/// @return {}
{} {}({}) {{
  {}
}}
]],
			{
				i(1, "brief description"),
				i(2, "paramName"),
				i(3, "description"),
				i(4, "void"),
				rep(4),
				i(5, "myFunction"),
				i(6, "int a"),
				i(0),
			}
		)
	),

	-- Class with Doxygen
	s(
		"clsd",
		fmt(
			[[
/// @brief {}
class {} {{
public:
  {}({}); // Constructor
  ~{}();  // Destructor

private:
  {}
}};
]],
			{
				i(1, "brief description"),
				i(2, "MyClass"),
				rep(2),
				i(3),
				rep(2),
				i(0),
			}
		)
	),

	-- main with Doxygen
	s(
		"maindoc",
		fmt(
			[[
/// @brief {}
/// @param argc Number of command line arguments
/// @param argv Array of command line arguments
/// @return {}
int main(int argc, char* argv[]) {{
  std::vector<std::string> args(argv + 1, argv + argc);
  {}
  return 0;
}}
]],
			{
				i(1, "Main entry point for the application."),
				i(2, "0 on success"),
				i(0),
			}
		)
	),
})

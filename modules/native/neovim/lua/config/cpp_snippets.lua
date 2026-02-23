-- lua/config/cpp_snippets.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("cpp", {

	-- =========================================================
	-- Competitive Programming
	-- =========================================================

	s(
		"compmain",
		fmt(
			[[
#include <bits/stdc++.h>
using namespace std;

int main() {{
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    {}

    return 0;
}}
]],
			{ i(0) }
		)
	),

	s(
		"fastio",
		fmt(
			[[
ios::sync_with_stdio(false);
cin.tie(nullptr);
]],
			{}
		)
	),

	s(
		"cpdefs",
		fmt(
			[[
using ll = long long;
using ull = unsigned long long;
using pii = pair<int,int>;
using pll = pair<long long,long long>;
constexpr int INF = 1e9;
constexpr long long LINF = 1e18;
]],
			{}
		)
	),

	s(
		"pbds",
		fmt(
			[[
#include <ext/pb_ds/assoc_container.hpp>
#include <ext/pb_ds/tree_policy.hpp>
using namespace __gnu_pbds;

template<typename T>
using ordered_set = tree<
    T,
    null_type,
    less<T>,
    rb_tree_tag,
    tree_order_statistics_node_update>;
]],
			{}
		)
	),

	s(
		"bs",
		fmt(
			[[
int l = 0, r = {} - 1;
while (l <= r) {{
    int mid = l + (r - l) / 2;
    if ({}) {{
        r = mid - 1;
    }} else {{
        l = mid + 1;
    }}
}}
]],
			{ i(1, "n"), i(0, "condition") }
		)
	),

	s(
		"dbgcp",
		fmt(
			[[
#ifdef LOCAL
#define dbg(x) cerr << #x << " = " << (x) << endl;
#else
#define dbg(x)
#endif
]],
			{}
		)
	),

	s(
		"bench",
		fmt(
			[[
template<typename F>
void benchmark(std::string_view name, F&& fn) {{
    auto start = std::chrono::high_resolution_clock::now();
    fn();
    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> diff = end - start;
    std::cout << name << ": " << diff.count() << " s\n";
}}
]],
			{}
		)
	),

	-- =========================================================
	-- Modern Templates / Meta
	-- =========================================================

	s(
		"tfunc",
		fmt(
			[[
template<typename {}>
{} {}({} {}) {{
    {}
}}
]],
			{
				i(1, "T"),
				i(2, "void"),
				i(3, "func"),
				rep(1),
				i(4, "value"),
				i(0),
			}
		)
	),

	s(
		"concept",
		fmt(
			[[
#include <concepts>

template<typename T>
concept {} = requires(T a) {{
    {};
}};
]],
			{ i(1, "ConceptName"), i(0) }
		)
	),

	s(
		"requires",
		fmt(
			[[
template<typename T>
requires {}
void {}(T {}) {{
    {}
}}
]],
			{
				i(1, "std::integral<T>"),
				i(2, "func"),
				i(3, "value"),
				i(0),
			}
		)
	),

	s(
		"ifc",
		fmt(
			[[
if constexpr ({}) {{
    {}
}} else {{
    {}
}}
]],
			{ i(1, "cond"), i(2), i(0) }
		)
	),

	s(
		"fold",
		fmt(
			[[
template<typename... Args>
auto {}(Args... args) {{
    return ({} + ...);
}}
]],
			{ i(1, "sum"), i(2, "args") }
		)
	),

	s(
		"cexpr",
		fmt(
			[[
constexpr auto {}(auto x) {{
    {}
}}
]],
			{ i(1, "func"), i(0) }
		)
	),

	s(
		"hashconstexpr",
		fmt(
			[[
constexpr uint64_t fnv1a(std::string_view str) {{
    uint64_t hash = 1469598103934665603ull;
    for (char c : str)
        hash = (hash ^ c) * 1099511628211ull;
    return hash;
}}
]],
			{}
		)
	),

	-- =========================================================
	-- C++23
	-- =========================================================

	s(
		"print23",
		fmt(
			[[
#include <print>
std::println("{}: {{}}", {});
]],
			{ i(1, "label"), i(2, "value") }
		)
	),

	s(
		"expected",
		fmt(
			[[
#include <expected>

std::expected<{}, {}> {};
]],
			{ i(1, "T"), i(2, "E"), i(3, "result") }
		)
	),

	s(
		"mdspan",
		fmt(
			[[
#include <mdspan>

std::mdspan<{}, std::extents<size_t, {}, {}>> {}({});
]],
			{
				i(1, "float"),
				i(2, "rows"),
				i(3, "cols"),
				i(4, "view"),
				i(5, "data"),
			}
		)
	),

	s(
		"ranges",
		fmt(
			[[
#include <ranges>

auto {} = {} | std::views::filter([](auto x) {{
    return {};
}});
]],
			{ i(1, "result"), i(2, "container"), i(0, "condition") }
		)
	),

	-- =========================================================
	-- Systems / Performance
	-- =========================================================

	s(
		"timer",
		fmt(
			[[
#include <chrono>

auto start = std::chrono::high_resolution_clock::now();

{}

auto end = std::chrono::high_resolution_clock::now();
std::chrono::duration<double> diff = end - start;
std::cout << "Time: " << diff.count() << " s\n";
]],
			{ i(0) }
		)
	),

	s(
		"simd",
		fmt(
			[[
#include <immintrin.h>

for (size_t {} = 0; {} < {}; {} += 8) {{
    __m256 {} = _mm256_loadu_ps(&{}[{}]);
    {}
}}
]],
			{
				i(1, "i"),
				i(1),
				i(2, "N"),
				i(1),
				i(3, "vec"),
				i(4, "data"),
				i(1),
				i(0),
			}
		)
	),

	s(
		"avxadd",
		fmt(
			[[
__m256 {} = _mm256_add_ps({}, {});
]],
			{
				i(1, "result"),
				i(2, "a"),
				i(3, "b"),
			}
		)
	),

	s(
		"avxfma",
		fmt(
			[[
__m256 {} = _mm256_fmadd_ps({}, {}, {});
]],
			{
				i(1, "result"),
				i(2, "a"),
				i(3, "b"),
				i(4, "c"),
			}
		)
	),

	s(
		"avxstore",
		fmt(
			[[
_mm256_storeu_ps(&{}[{}], {});
]],
			{
				i(1, "data"),
				i(2, "i"),
				i(3, "vec"),
			}
		)
	),

	s(
		"avxhsum",
		fmt(
			[[
float horizontal_sum(__m256 v) {{
    __m128 low = _mm256_castps256_ps128(v);
    __m128 high = _mm256_extractf128_ps(v, 1);
    low = _mm_add_ps(low, high);
    __m128 shuf = _mm_movehdup_ps(low);
    __m128 sums = _mm_add_ps(low, shuf);
    shuf = _mm_movehl_ps(shuf, sums);
    sums = _mm_add_ss(sums, shuf);
    return _mm_cvtss_f32(sums);
}}
]],
			{}
		)
	),

	s(
		"prefetch",
		fmt(
			[[
_mm_prefetch((const char*)(&{}[{}]), _MM_HINT_T0);
]],
			{
				i(1, "data"),
				i(2, "i"),
			}
		)
	),

	s(
		"alignedalloc",
		fmt(
			[[
{}* {} = static_cast<{}*>(std::aligned_alloc({}, {}));
]],
			{
				i(1, "float"),
				i(2, "ptr"),
				i(1),
				i(3, "32"),
				i(4, "size"),
			}
		)
	),

	s(
		"avxmaskload",
		fmt(
			[[
__m256 {} = _mm256_maskload_ps(&{}[{}], {});
]],
			{
				i(1, "vec"),
				i(2, "data"),
				i(3, "i"),
				i(4, "mask"),
			}
		)
	),

	s(
		"avxmaskstore",
		fmt(
			[[
_mm256_maskstore_ps(&{}[{}], {}, {});
]],
			{
				i(1, "data"),
				i(2, "i"),
				i(3, "mask"),
				i(4, "vec"),
			}
		)
	),

	s(
		"avx512loop",
		fmt(
			[[
for (size_t {} = 0; {} < {}; {} += 16) {{
    __m512 {} = _mm512_loadu_ps(&{}[{}]);
    {}
}}
]],
			{
				i(1, "i"),
				i(1),
				i(2, "N"),
				i(1),
				i(3, "vec"),
				i(4, "data"),
				i(1),
				i(0),
			}
		)
	),

	s(
		"unroll",
		fmt(
			[[
#pragma unroll {}
for (int {} = 0; {} < {}; ++{}) {{
    {}
}}
]],
			{
				i(1, "4"),
				i(2, "i"),
				i(2),
				i(3, "N"),
				i(2),
				i(0),
			}
		)
	),

	s(
		"stdsimd",
		fmt(
			[[
#include <experimental/simd>

using simd_t = std::experimental::native_simd<{}>;

for (size_t {} = 0; {} < {}; {} += simd_t::size()) {{
    simd_t {}(&{}[{}], std::experimental::element_aligned);
    {}
}}
]],
			{
				i(1, "float"),
				i(2, "i"),
				i(2),
				i(3, "N"),
				i(2),
				i(4, "vec"),
				i(5, "data"),
				i(2),
				i(0),
			}
		)
	),

	-- =========================================================
	-- HIP (AMD GPU)
	-- =========================================================

	s(
		"hipkernel",
		fmt(
			[[
#include <hip/hip_runtime.h>

__global__ void {}({}* {}) {{
    int idx = blockIdx.x * blockDim.x + threadIdx.x;
    {}
}}
]],
			{
				i(1, "kernel"),
				i(2, "float"),
				i(3, "data"),
				i(0),
			}
		)
	),

	s(
		"hiplaunch",
		fmt(
			[[
dim3 block({});
dim3 grid(({} + block.x - 1) / block.x);

hipLaunchKernelGGL({}, grid, block, 0, 0, {});
hipDeviceSynchronize();
]],
			{
				i(1, "256"),
				i(2, "N"),
				i(3, "kernel"),
				i(4, "args"),
			}
		)
	),

	s(
		"hipmalloc",
		fmt(
			[[
{}* {};
hipMalloc(&{}, {});
]],
			{
				i(1, "float"),
				i(2, "d_ptr"),
				i(2),
				i(3, "size"),
			}
		)
	),

	s(
		"hipcpy",
		fmt(
			[[
hipMemcpy({}, {}, {}, {});
]],
			{
				i(1, "dst"),
				i(2, "src"),
				i(3, "size"),
				i(4, "hipMemcpyHostToDevice"),
			}
		)
	),

	s(
		"hipcheck",
		fmt(
			[[
#define HIP_CHECK(err) \
    if (err != hipSuccess) {{ \
        std::cerr << "HIP error: " << hipGetErrorString(err) << std::endl; \
        std::exit(EXIT_FAILURE); \
    }}
]],
			{}
		)
	),

	-- =========================================================
	-- Standard Containers
	-- =========================================================

	s(
		"vec",
		fmt(
			[[
std::vector<{}> {};
]],
			{ i(1, "T"), i(2, "vec") }
		)
	),

	s(
		"arr",
		fmt(
			[[
std::array<{}, {}> {};
]],
			{ i(1, "T"), i(2, "N"), i(3, "arr") }
		)
	),

	s(
		"map",
		fmt(
			[[
std::map<{}, {}> {};
]],
			{ i(1, "Key"), i(2, "Value"), i(3, "map") }
		)
	),

	s(
		"umap",
		fmt(
			[[
std::unordered_map<{}, {}> {};
]],
			{ i(1, "Key"), i(2, "Value"), i(3, "umap") }
		)
	),

	s(
		"set",
		fmt(
			[[
std::set<{}> {};
]],
			{ i(1, "T"), i(2, "set") }
		)
	),

	s(
		"uset",
		fmt(
			[[
std::unordered_set<{}> {};
]],
			{ i(1, "T"), i(2, "uset") }
		)
	),

	s(
		"deque",
		fmt(
			[[
std::deque<{}> {};
]],
			{ i(1, "T"), i(2, "dq") }
		)
	),

	s(
		"queue",
		fmt(
			[[
std::queue<{}> {};
]],
			{ i(1, "T"), i(2, "q") }
		)
	),

	s(
		"stack",
		fmt(
			[[
std::stack<{}> {};
]],
			{ i(1, "T"), i(2, "st") }
		)
	),

	s(
		"span",
		fmt(
			[[
std::span<{}> {};
]],
			{ i(1, "T"), i(2, "sp") }
		)
	),

	-- =========================================================
	-- Functions / Classes
	-- =========================================================

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
				i(2, "function_name"),
				i(3, ""),
				i(0),
			}
		)
	),

	s(
		"lambda",
		fmt(
			[[
auto {} = [{}]({}) {{
    {}
}};
]],
			{
				i(1, "fn"),
				i(2, "&"),
				i(3, ""),
				i(0),
			}
		)
	),

	s(
		"struct",
		fmt(
			[[
struct {} {{
    {}
}};
]],
			{ i(1, "Name"), i(0) }
		)
	),

	s(
		"class",
		fmt(
			[[
class {} {{
public:
    {}();
    ~{}();

private:
    {}
}};
]],
			{
				i(1, "ClassName"),
				rep(1),
				rep(1),
				i(0),
			}
		)
	),

	s(
		"ruleof5",
		fmt(
			[[
{}();
~{}();

{}(const {}&);
{}& operator=(const {}&);

{}({}&&) noexcept;
{}& operator=({}&&) noexcept;
]],
			{
				i(1, "Class"),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
				rep(1),
			}
		)
	),

	-- =========================================================
	-- Logic / Control Flow
	-- =========================================================

	s(
		"if",
		fmt(
			[[
if ({}) {{
    {}
}}
]],
			{ i(1, "condition"), i(0) }
		)
	),

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
			{ i(1, "condition"), i(2), i(0) }
		)
	),

	s(
		"fori",
		fmt(
			[[
for (int {} = 0; {} < {}; ++{}) {{
    {}
}}
]],
			{
				i(1, "i"),
				rep(1),
				i(2, "N"),
				rep(1),
				i(0),
			}
		)
	),

	s(
		"forr",
		fmt(
			[[
for (auto& {} : {}) {{
    {}
}}
]],
			{
				i(1, "elem"),
				i(2, "container"),
				i(0),
			}
		)
	),

	s(
		"try",
		fmt(
			[[
try {{
    {}
}} catch (const std::exception& e) {{
    std::cerr << e.what() << std::endl;
}}
]],
			{ i(0) }
		)
	),

	-- =========================================================
	-- Preprocessor
	-- =========================================================

	s(
		"once",
		fmt(
			[[
#pragma once

{}
]],
			{ i(0) }
		)
	),

	s(
		"inc",
		fmt(
			[[
#include <{}>
]],
			{ i(1, "iostream") }
		)
	),

	s(
		"incc",
		fmt(
			[[
#include "{}"
]],
			{ i(1, "header.hpp") }
		)
	),
})

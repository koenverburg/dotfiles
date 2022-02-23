local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_nodel
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.expand_conditions")

function snip(name, value)
	return ls.parser.parse_snippet(name, value)
end

local frontend = {
	snip("shrug", "// ¯\\_(ツ)_/¯ ${1}"),

	snip("lg", "console.log({ ${1} })"),

	snip("yieldp", "yield put(${1})"),
	snip("yieldc", "yield call(${1})"),

	snip("impd", "import ${1} from '${2}'"),
	snip("impo", "import { ${1} } from '${2}'"),

	snip("func", "function ${1}() {\n${2}\n}"),

	s(
		"fmt2",
		fmt(
			[[
			foo({1}, {3}) {{
				return {2} * {4}
			}}
			]],
			{
				i(1, "x"),
				rep(1),
				i(2, "y"),
				rep(2),
			}
		)
	),

	snip("ifc", "if (${1}) {\n${2}\n}"),

	snip("rtrn", "return ${1}"),
}

ls.snippets = {
	typescript = frontend,
	javascript = frontend,
	lua = {
		snip("req", 'local ${1} = require("${2}")'),
		snip("lm", "local M = {}"),
	},
}

local ls = require("luasnip")
-- local s = ls.snippet
-- local sn = ls.snippet_node
-- local t = ls.text_node
-- local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_nodel
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local p = require("luasnip.extras").partial
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local types = require("luasnip.util.types")
-- local conds = require("luasnip.extras.expand_conditions")

function snip(name, value)
  return ls.parser.parse_snippet(name, value)
end

local frontend = {
  ls.parser.parse_snippet("lg", "console.log({ ${1} })"),
  ls.parser.parse_snippet("lg", "console.log({ ${1} })")

  ls.parser.parse_snippet("yieldp", "yield put(${1})"),
  ls.parser.parse_snippet("yieldc", "yield call(${1})"),

  ls.parser.parse_snippet("func", "function ${1}() {\n${2}\n}"),
  ls.parser.parse_snippet("func", "function ${1}() {\n${2}\n}"),

  ls.parser.parse_snippet("impd", "import ${1} from ${2}"),
  ls.parser.parse_snippet("impo", "import { ${1} } from ${2}"),

  ls.parser.parse_snippet("if", "if (${1}) {\n${2}\n}"),
  ls.parser.parse_snippet("rtrn", "return ${1}"),
}

ls.snippets = {
  typescript = frontend,
  javascript = frontend,
}


local ls = require("luasnip")

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("markdown", {
  s("hthree", fmt("### {}", { i(1) })),
  s("hfour", fmt("#### {}", { i(1) })),
  s("hfive", fmt("##### {}", { i(1) })),
  s("hsix", fmt("###### {}", { i(1) })),
  s("arrowup", t("↑")),
  s("arrowdown", t("↓")),
})

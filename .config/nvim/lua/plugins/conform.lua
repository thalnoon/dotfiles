return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters = {
      ["markdown-toc"] = {
        condition = function(_, ctx)
          for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
            if line:find("<!%-%- toc %-%->") then
              return true
            end
          end
        end,
      },
    },
    formatters_by_ft = {
      ["markdown"] = { "markdown-toc" },
      ["markdown.mdx"] = { "markdown-toc" },
      ["typst"] = { "typstfmt" },
      ["kotlin"] = { "ktlint" },
      ["python"] = { "mypy", "ruff", "black" },
    },
  },
}

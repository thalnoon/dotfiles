return {
  "hrsh7th/nvim-cmp",

  dependencies = { "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-cmdline", "hrsh7th/cmp-path", "chrisgrieser/cmp-nerdfont" },
  opts = function(_, opts)
    local cmp = require("cmp")
    table.insert(opts.sources, { name = "neorg" })
    opts.mapping = vim.tbl_deep_extend("force", opts.mapping, {
      ["<CR>"] = cmp.config.disable,
    })
    opts.snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    }
    table.insert(opts.sources, { name = "luasnip" })
    table.insert(opts.sources, { name = "nerdfont" })
    -- `:` cmdline setup.
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" },
          },
        },
      }),
    })
  end,

  keys = {
    {
      "<c-n>",
      function()
        require("luasnip").jump(1)
      end,
      mode = "s",
    },
    {
      "<c-e>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
    },
  },
}

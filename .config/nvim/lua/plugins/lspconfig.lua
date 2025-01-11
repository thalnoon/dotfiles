return {
  "neovim/nvim-lspconfig",
  event = "LazyFile",
  dependencies = {
    "mason.nvim",
    { "williamboman/mason-lspconfig.nvim", config = function() end },
  },
  require("lspconfig").tinymist.setup({
    settings = {
      formatterMode = "typstyle",
    },
  }),
}

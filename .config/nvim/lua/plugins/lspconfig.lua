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
  require("lspconfig").kotlin_language_server.setup({}),
}

return {
  "nvim-telescope/telescope-file-browser.nvim",
  enabled = false,
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  config = function()
    local picker = require("telescope._extensions.file_browser")
    require("telescope").setup({
      extensions = {
        file_browser = {
          theme = "ivy",
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          depth = 2,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
              vim.keymap.set("n", "<space>fl", function()
                require("telescope").extensions.file_browser.file_browser()
              end),
            },
          },
        },
      },
    })
  end,
}

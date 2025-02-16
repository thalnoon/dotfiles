local telescope_ignore_patterns = {
  "%.jpg",
  "%.jpeg",
  "%.png",
  "^.cache/",
  "^.bun/",
  "^.icons/",
  "^.npm/",
  "^.obsidian/",
}
return {
  "nvim-telescope/telescope.nvim",
  enabled = false,
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },

  opts = {
    pickers = {
      find_files = {
        theme = "ivy",
      },
    },
    defaults = {
      file_ignore_patterns = telescope_ignore_patterns,
    },
  },
  keys = {
    { "<leader>fn", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
  },
}

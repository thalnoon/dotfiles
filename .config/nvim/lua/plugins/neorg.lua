return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = true,
  opts = {
    load = {
      ["core.defaults"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "",
          },
        },
      },
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.integrations.nvim-cmp"] = {},
      ["core.concealer"] = {},
      ["core.keybinds"] = {
        config = {
          neorg_leader = ";",
        },
      },
    },
  },
}

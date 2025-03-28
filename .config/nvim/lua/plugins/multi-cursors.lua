-- lazy.nvim:
return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  enabled = false,
  dependencies = {
    "nvimtools/hydra.nvim",
  },
  opts = {},
  cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
  keys = {
    {
      mode = { "v", "n" },
      "<c-n>",
      "<cmd>MCstart<cr>",
      desc = "Create a selection for selected text or word under the cursor",
    },
  },
}

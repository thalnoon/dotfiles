return {
  "mg979/vim-visual-multi",
  enabled = true,
  init = function()
    vim.g.VM_maps = {
      ["Add Cursor Down"] = "",
      ["Add Cursor Up"] = "",
    }
  end,
  config = function()
    vim.keymap.set("n", "<leader>mp", "<Plug>(VM-Add-Cursor-At-Pos)", { desc = "Add Cursor at Position" })
    vim.keymap.set("n", "<leader>ma", "<Plug>(VM-Select-All)<Tab>", { desc = "Select All" })
    vim.keymap.set("n", "<leader>mr", "<Plug>(VM-Start-Regex-Search)", { desc = "Start Regex Search Multi Cursor" })
  end,
}

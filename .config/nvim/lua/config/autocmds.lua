-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- typst autocompilation
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.typ",
  callback = function()
    -- Replace `typst` and paths with your actual Typst command or setup.
    local input_file = vim.fn.expand("<afile>")
    local output_file = vim.fn.fnamemodify(input_file, ":r") .. ".pdf"
    local command = string.format("typst compile %s %s", input_file, output_file)

    -- Execute the Typst compile command
    local result = vim.fn.system(command)

    -- Optionally, notify the user
    if vim.v.shell_error == 0 then
      vim.notify("Typst compiled successfully: " .. output_file, vim.log.levels.INFO)
    else
      vim.notify("Typst compilation failed:\n" .. result, vim.log.levels.ERROR)
    end
  end,
})

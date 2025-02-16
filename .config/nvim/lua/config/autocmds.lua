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

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

-- -- Add to your init.lua
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = "*.md",
--   group = vim.api.nvim_create_augroup("MarkdownMarkConceal", { clear = true }),
--   callback = function(args)
--     local buf = args.buf
--
--     -- Conceal opening <mark> tags (with attributes)
--     vim.fn.matchadd("Conceal", [[<\m\(mark\)\_.\{-}>]], 10, -1, { conceal = "", buffer = buf })
--
--     -- Conceal closing </mark> tags
--     vim.fn.matchadd("Conceal", [[</\m\(mark\)>]], 10, -1, { conceal = "", buffer = buf })
--
--     -- Required conceal settings
--     vim.wo[buf].conceallevel = 2
--     vim.wo[buf].concealcursor = "nc"
--   end,
-- })

-- -- Configure conceal for <mark> tags in Markdown
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = "*.md",
--   group = vim.api.nvim_create_augroup("MarkdownMarkConceal", { clear = true }),
--   callback = function(args)
--     local buf = args.buf
--     local win = vim.fn.bufwinid(buf) -- Get window ID for the buffer
--
--     -- Highlight <mark> tags with HTML syntax
--     vim.fn.matchadd("htmlTag", [[<\m\(mark\)\_.\{-}>]], 10, -1, { buffer = buf })
--     vim.fn.matchadd("htmlTag", [[</\m\(mark\)>]], 10, -1, { buffer = buf })
--
--     -- Conceal tags in Normal mode only
--     vim.fn.matchadd("Conceal", [[<\m\(mark\)\_.\{-}>]], 11, -1, { conceal = "", buffer = buf })
--     vim.fn.matchadd("Conceal", [[</\m\(mark\)>]], 11, -1, { conceal = "", buffer = buf })
--
--     vim.api.nvim_set_hl(0, "Conceal", {
--       fg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg, -- Match background
--       bg = "NONE",
--     })
--
--     -- Set window-local options for the current window
--     vim.wo[win].conceallevel = 3
--     vim.wo[win].concealcursor = "nci" -- Show in Visual/Insert modes
--   end,
-- })
--
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter" }, {
  pattern = "*.md",
  group = vim.api.nvim_create_augroup("MarkdownMarkConceal", { clear = true }),
  callback = function(args)
    local buf = args.buf
    local win = vim.fn.bufwinid(buf)

    -- Your existing conceal setup
    vim.fn.matchadd("htmlTag", [[<\m\(mark\)\_.\{-}>]], 10, -1, { buffer = buf })
    vim.fn.matchadd("htmlTag", [[</\m\(mark\)>]], 10, -1, { buffer = buf })
    vim.fn.matchadd("Conceal", [[<\m\(mark\)\_.\{-}>]], 11, -1, { conceal = "", buffer = buf })
    vim.fn.matchadd("Conceal", [[</\m\(mark\)>]], 11, -1, { conceal = "", buffer = buf })

    -- Defer window option setting
    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(win) then
        vim.wo[win].conceallevel = 3
        vim.wo[win].concealcursor = "nci"
      end
    end, 10)
  end,
})

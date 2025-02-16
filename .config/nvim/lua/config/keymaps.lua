-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- hello
-- hello
-- hello
vim.g.mapleader = " " -- sets the leader key to space
-- vim.keymap.del("n", "<M-n>")
--vim.keymap.del("n", "<M-i>")
--vim.keymap.del("n", "<M-u>")
--vim.keymap.del("n", "<M-e>")

local set = vim.keymap.set -- for conciseness

------------------------------
-- General keymaps ============
-- Switch between dark and light mode
set("n", "<leader>ntl", "<CMD>set background=light<CR>", { desc = "Switch to light mode" })
set("n", "<leader>ntd", "<CMD>set background=dark<CR>", { desc = "Switch to dark mode" })
set("n", "<leader>tt", "<CMD>term<CR>", { desc = "Switch to dark mode" })
set("n", "x", '"_x')

local opts = { noremap = true, silent = true }

-- use jk to exit insert mode
set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
set("i", "<A-t>", "<C-t>", { desc = "Exit insert mode with jk" })
set("n", "<C-e>", "<C-d>", { desc = "Move down in page" })
set("t", "<ESC>", "<C-\\><C-N>", { desc = "Exit terminal mode" })
set("i", "nn", "<ESC>", { desc = "Exit insert mode with nn" })
set({ "n", "i" }, "<C-q>", "<CMD>q<CR>", { desc = "Exit Neovim" })
set({ "n", "i" }, "<C-x>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
set("n", "<C-y>", "yyp")

-- clear search highlights
set("n", "<leader>ch", ":nohl<CR>", { desc = "Clear search highlights" })
-- set("n", "W", "b")

-- increment/decrement numbers
set("n", "=", "<C-a>", { desc = "Increment number" })
set("n", "-", "<C-x>", { desc = "Decrement number" })

vim.keymap.set("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return "<cmd>ObsidianFollowLink<CR>"
  else
    return "gf"
  end
end, { noremap = false, expr = true })

-- Obsidian
set("n", "<leader>on", "<CMD>ObsidianNew<CR>")
set("n", "<leader>ot", "<CMD>ObsidianTemplate<CR>")
set("n", "<leader>om", "<CMD>ObsidianNewFromTemplate<CR>")
set("n", "<leader>oo", "<CMD>ObsidianOpen<CR>")
set("n", "<leader>or", "<CMD>ObsidianRename<CR>")
-- Create a command to allow custom symbols
vim.api.nvim_create_user_command("Surround", function(opts)
  local start_symbol, end_symbol = unpack(vim.split(opts.args, " "))
  surround_with_symbols(start_symbol, end_symbol)
end, { nargs = "+" })

function wrap_with(start_char, end_char)
  -- Get the visual selection start and end positions
  local beg_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  -- Go to the end of the visual selection and append the end_char
  vim.api.nvim_exec("normal! `>a" .. end_char, false)

  -- Go to the start of the visual selection and insert the start_char
  vim.api.nvim_exec("normal! `<i" .. start_char, false)
end

-- Keymaps for Wrapping with Specific Characters
-- vim.api.nvim_set_keymap("v", "((", ':lua wrap_with("((", "))")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<leader>ml", ':lua wrap_with("[[", "]]")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "{{", ':lua wrap_with("{{", "}}")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<<", ':lua wrap_with("<<", ">>")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<C-b>", ':lua wrap_with("**", "**")<CR>', { noremap = true, silent = true })
-- --vim.api.nvim_set_keymap("v", "<C-i>", ':lua wrap_with("_", "_")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<A-u>", ':lua wrap_with("<u>", "</u>")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "((", ':lua wrap_with("((", "))")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>ml", ':lua wrap_with("[[", "]]")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "{{", ':lua wrap_with("{{", "}}")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<<", ':lua wrap_with("<<", ">>")<CR>', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<c-b>", ':lua wrap_with("**", "**")<CR>', { noremap = true, silent = true })
--vim.api.nvim_set_keymap("n", "<c-i>", ':lua wrap_with("_", "_")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<a-u>", ':lua wrap_with("<u>", "</u>")<CR>', { noremap = true, silent = true })

vim.keymap.set("n", "<leader><leader>r", "<CMD>SearchBoxReplace<CR>")

-- Capitalize words in selection

-- Visual mode mapping
vim.api.nvim_set_keymap("x", "<leader>uc", [[:s/\%V\<./\u&/g<CR>:nohlsearch<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>uc", [[:s/\%V\<./\u&/g<CR>:nohlsearch<CR>]], { noremap = true, silent = true })

-- Normal mode mapping
vim.api.nvim_set_keymap("n", "<leader>uc", [[:s/\<./\u&/g<CR>:nohlsearch<CR>]], { noremap = true, silent = true })
--
-- markdown_toc

-- Generate/update a Markdown toc
-- To generate the TOC I use the markdown-toc plugin
-- https://github.com/jonschlinkert/markdown-toc
-- And the markdown-toc plugin installed as a LazyExtra
-- Function to update the markdown toc with customizable headings
--local function update_markdown_toc(heading2, heading3)
--  local path = vim.fn.expand("%") -- expands the current file name to a full path
--  local bufnr = 0 -- The current buffer number, 0 references the current active buffer
--  -- Save the current view
--  -- If I don't do this, my folds are lost when I run this keymap
--  vim.cmd("mkview")
--  -- Retrieves all lines from the current buffer
--  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--  local toc_exists = false -- flag to check if TOC marker exists
--  local frontmatter_end = 0 -- to store the end line number of frontmatter
--  -- Check for frontmatter and toc marker
--  for i, line in ipairs(lines) do
--    if i == 1 and line:match("^---$") then
--      -- Frontmatter start detected, now find the end
--      for j = i + 1, #lines do
--        if lines[j]:match("^---$") then
--          frontmatter_end = j
--          break
--        end
--      end
--    end
--    -- Checks for the TOC marker
--    if line:match("^%s*<!%-%-%s*toc%s*%-%->%s*$") then
--      toc_exists = true
--      break
--    end
--  end
--  -- Inserts H2 and H3 headings and <!-- toc --> at the appropriate position
--  if not toc_exists then
--    local insertion_line = 1 -- default insertion point after first line
--    if frontmatter_end > 0 then
--      -- Find H1 after frontmatter
--      for i = frontmatter_end + 1, #lines do
--        if lines[i]:match("^#%s+") then
--          insertion_line = i + 1
--          break
--        end
--      end
--    else
--      -- Find H1 from the beginning
--      for i, line in ipairs(lines) do
--        if line:match("^#%s+") then
--          insertion_line = i + 1
--          break
--        end
--      end
--    end
--    -- Insert the specified headings and <!-- toc --> without blank lines
--    -- Insert the TOC inside a h2 and h3 heading right below the main H1 at the top lamw25wmal
--    vim.api.nvim_buf_set_lines(bufnr, insertion_line, insertion_line, false, { heading2, heading3, "<!-- toc -->" })
--  end
--  -- Silently save the file, in case toc is being created for the first time
--  vim.cmd("silent write")
--  -- Silently run markdown-toc to update the TOC without displaying command output
--  -- vim.fn.system("markdown-toc -i " .. path)
--  -- I want my bulletpoints to be created only as "-" so passing that option as
--  -- an argument according to the docs
--  -- https://github.com/jonschlinkert/markdown-toc?tab=readme-ov-file#optionsbullets
--  vim.fn.system('markdown-toc --bullets "-" -i ' .. path)
--  vim.cmd("edit!") -- Reloads the file to reflect the changes made by markdown-toc
--  vim.cmd("silent write") -- silently save the file
--  vim.notify("TOC updated and file saved", vim.log.levels.INFO)
--  -- -- In case a cleanup is needed, leaving this old code here as a reference
--  -- -- I used this code before i implemented the frontmatter check
--  -- -- Moves the cursor to the top of the file
--  -- vim.api.nvim_win_set_cursor(bufnr, { 1, 0 })
--  -- -- Deletes leading blank lines from the top of the file
--  -- while true do
--  --   -- Retrieves the first line of the buffer
--  --   local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
--  --   -- Checks if the line is empty
--  --   if line == "" then
--  --     -- Deletes the line if it's empty
--  --     vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, {})
--  --   else
--  --     -- Breaks the loop if the line is not empty, indicating content or TOC marker
--  --     break
--  --   end
--  -- end
--  -- Restore the saved view (including folds)
--  vim.cmd("loadview")
--end
---- Keymap for English TOC
--vim.keymap.set("n", "<leader>mtt", function()
--  update_markdown_toc("##contents", "### table of contents")
--end, { desc = "[P]Insert/update markdown tOC (English)" })

-- File Explorer - Oil
--vim.keymap.set("n", "<leader>e", "<cmd>oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>mvs", "<CMD>Markview splitEnable<CR>", { desc = "Markview Split view toggle" })
vim.keymap.set("n", "<leader>mvh", "<CMD>Markview hybridEnable<CR>", { desc = "Markview Hybrid view toggle" })
-- vim.keymap.set("n", "<leader>e", function()
--   require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
-- end, { desc = "Open parent directory" })
--
-- vim.keymap.set("n", "<leader>E", function()
--   require("mini.files").open(vim.uv.cwd(), true)
-- end, { desc = "Open mini.files (cwd)" })

-- -- Colemak Layout Settings
-- -- Function to toggle remapping
-- local mappings_applied = false
-- local function toggle_mappings()
--   if mappings_applied then
--     -- Unmap the keys
--     local modes = { "n", "v", "x" }
--     local keys = { "m", "n", "e", "i", "M", "N", "E", "I" }
--     for _, mode in ipairs(modes) do
--       for _, key in ipairs(keys) do
--         vim.keymap.del(mode, key)
--       end
--     end
--     mappings_applied = false
--     print("Colemak remappings disabled")
--   else
--     -- Apply the mappings
--     local opts = { noremap = true, silent = true }
--     vim.keymap.set("n", "m", "h", opts)
--     vim.keymap.set("n", "n", "j", opts)
--     vim.keymap.set("n", "e", "k", opts)
--     vim.keymap.set("n", "i", "l", opts)
--     vim.keymap.set("n", "M", "H", opts)
--     vim.keymap.set("n", "N", "J", opts)
--     vim.keymap.set("n", "E", "K", opts)
--     vim.keymap.set("n", "I", "L", opts)
--
--     vim.keymap.set("v", "m", "h", opts)
--     vim.keymap.set("v", "n", "j", opts)
--     vim.keymap.set("v", "e", "k", opts)
--     vim.keymap.set("v", "i", "l", opts)
--     vim.keymap.set("v", "M", "H", opts)
--     vim.keymap.set("v", "N", "J", opts)
--     vim.keymap.set("v", "E", "K", opts)
--     vim.keymap.set("v", "I", "L", opts)
--
--     vim.keymap.set("x", "m", "h", opts)
--     vim.keymap.set("x", "n", "j", opts)
--     vim.keymap.set("x", "e", "k", opts)
--     vim.keymap.set("x", "i", "l", opts)
--     vim.keymap.set("x", "M", "H", opts)
--     vim.keymap.set("x", "N", "J", opts)
--     vim.keymap.set("x", "E", "K", opts)
--     vim.keymap.set("x", "I", "L", opts)
--     vim.keymap.set("i", "nn", "<ESC>", opts)
--
--     mappings_applied = true
--     print("Colemak remappings enabled")
--   end
-- end
--
-- -- Map the toggle function to <leader>k
-- vim.keymap.set("n", "<leader>k", toggle_mappings, { noremap = true, silent = true })
--
--

vim.keymap.set("n", "<C-Up>", "<CMD>wincmd k<CR>", opts)
vim.keymap.set("n", "<C-Down>", "<CMD>wincmd j<CR>", opts)
vim.keymap.set("n", "<C-Right>", "<CMD>wincmd l<CR>", opts)
vim.keymap.set("n", "<C-Left>", "<CMD>wincmd h<CR>", opts)

vim.keymap.set("n", "<C-Left>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<C-Down>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<C-Up>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>TmuxNavigateRight<cr>")

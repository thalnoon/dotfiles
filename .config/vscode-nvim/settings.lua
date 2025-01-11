local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local trueremap = { remap = true}
-- remap leader key
keymap("n", "<Space>", "", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- yank to system clipboard
keymap({"n", "v"}, "<leader>y", '"+y', opts)

-- paste from system clipboard
keymap({"n", "v"}, "<leader>p", '"+p', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- move text up and down
keymap("v", "J", ":m .+1<CR>==", opts)
keymap("v", "K", ":m .-2<CR>==", opts)
keymap("n", "J", ":m .+1<CR>==", opts)
keymap("n", "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- paste preserves primal yanked piece
keymap("v", "p", '"_dP', opts)

-- removes highlighting after escaping vim search
keymap({"n", "v"}, "<Esc>", "<Esc>:nohl<CR>")
keymap({"n", "v"}, "<L>", "$", trueremap)
keymap({"n", "v"}, "<H>", "0", trueremap)
keymap({"n", "v"}, "t", "%", trueremap)

-- Map <leader>o & <leader>O to newline without insert mode
keymap("n", "<space>o",
  [[:<C-u>call append(line("."), repeat([""], v:count1))<CR>]],
  { silent = true, desc = "newline below (no insert-mode)" })
keymap("n", "<space>O",
  [[:<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>]],
  { silent = true, desc = "newline above (no insert-mode)" })


------------------------------
-- General keymaps ============


-- clear search highlights
keymap("n", "<Space>nc", ":nohl<CR>", opts)

-- increment/decrement numbers
keymap("n", "<leader>=", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap('n', '<leader>',"<cmd>lua require('vscode').action('whichkey.show')<CR>")


keymap({'n', 'v'}, "Y", "\"+y")
keymap({'n', 'v'}, "YY", "\"+yy")
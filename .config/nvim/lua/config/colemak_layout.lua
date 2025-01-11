-- Colemak Layout Settings with Explicit Reversion
local M = {}

-- Define the Colemak mappings
M.colemak_mappings = {
  { from = "m", to = "h" },
  { from = "M", to = "H" },
  { from = "n", to = "j" },
  { from = "N", to = "J" },
  { from = "e", to = "k" },
  { from = "E", to = "K" },
  { from = "i", to = "l" },
  { from = "I", to = "L" },
  { from = "k", to = "i" },
  { from = "l", to = "e" },
  { from = "L", to = "E" },
  { from = "h", to = "n" },
  { from = "H", to = "N" },
}

-- Modes where we want to apply the mappings
M.modes = { "n", "v", "x" } -- Normal, Visual, and Visual Block modes

-- QWERTY defaults for manual reversion
M.qwerty_defaults = {
  { from = "m", to = "m" },
  { from = "M", to = "M" },
  { from = "n", to = "n" },
  { from = "N", to = "N" },
  { from = "e", to = "e" },
  { from = "E", to = "E" },
  { from = "i", to = "i" },
  { from = "I", to = "I" },
  { from = "k", to = "k" },
  { from = "K", to = "K" },
  { from = "e", to = "e" },
  { from = "E", to = "E" },
  { from = "h", to = "h" },
  { from = "H", to = "H" },
  { from = "l", to = "l" },
  { from = "L", to = "L" },
}

-- Function to apply Colemak mappings
local function apply_colemak()
  -- Apply Colemak mappings for each mode
  for _, mode in ipairs(M.modes) do
    for _, mapping in ipairs(M.colemak_mappings) do
      pcall(vim.keymap.set, mode, mapping.from, mapping.to, { noremap = true, silent = true })
    end
  end

  -- Add Insert mode escape mapping

  M.mappings_applied = true
  vim.notify("Colemak mappings enabled", vim.log.levels.INFO)
end

-- Function to revert all keys to QWERTY defaults
local function restore_qwerty()
  -- Explicitly revert all keys to QWERTY behavior
  for _, mode in ipairs(M.modes) do
    for _, mapping in ipairs(M.qwerty_defaults) do
      pcall(vim.keymap.set, mode, mapping.from, mapping.to, { noremap = true, silent = true })
    end
  end

  -- Remove Insert mode escape mapping

  M.mappings_applied = false
  vim.notify("QWERTY mappings restored", vim.log.levels.INFO)
end

-- Toggle function
function M.toggle_mappings()
  if M.mappings_applied then
    restore_qwerty()
  else
    apply_colemak()
  end
end

-- Set up the toggle keymap
vim.keymap.set("n", "<leader>k", M.toggle_mappings, { noremap = true, silent = true })

return M

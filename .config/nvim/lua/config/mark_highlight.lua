-- ~/.config/nvim/lua/mark_highlight.lua
local M = {}

-- Function to extract color and text from mark tag
local function extract_mark_info(line)
  local color = line:match("background:%s*([#%w]+)")
  local text = line:match("<mark[^>]*>(.-)</mark>")
  return color, text
end

-- Function to create highlight group for a specific color
local function create_highlight_group(color)
  -- Process the color to remove alpha channel if present
  local processed_color = color
  -- Extract the hex part without the # and check its length
  local hex_part = processed_color:sub(2) -- Remove the leading #
  if #hex_part > 6 then
    hex_part = hex_part:sub(1, 6) -- Truncate to 6 characters
    processed_color = "#" .. hex_part
  end

  local group_name = "MarkHighlight" .. processed_color:gsub("#", "")
  vim.api.nvim_set_hl(0, group_name, {
    fg = "black",
    bg = processed_color,
  })
  return group_name
end

-- Function to apply highlights to buffer
function M.apply_mark_highlights()
  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  -- Clear existing extmarks
  local ns_id = vim.api.nvim_create_namespace("mark_highlights")
  vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

  for lnum, line in ipairs(lines) do
    if line:match("<mark.*>.*</mark>") then
      local color, text = extract_mark_info(line)
      if color and text then
        local group_name = create_highlight_group(color)

        -- Find the start position of the text
        local start_col = line:find(text) - 1
        if start_col >= 0 then
          vim.api.nvim_buf_add_highlight(bufnr, ns_id, group_name, lnum - 1, start_col, start_col + #text)
        end
      end
    end
  end
end

-- Set up autocommands to apply highlights
function M.setup()
  local group = vim.api.nvim_create_augroup("MarkHighlight", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
    group = group,
    callback = M.apply_mark_highlights,
  })
end

return M

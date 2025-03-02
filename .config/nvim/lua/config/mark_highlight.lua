-- ~/.config/nvim/lua/mark_highlight.lua
local M = {}

-- Namespace for our virtual text and highlights
local namespace = vim.api.nvim_create_namespace("mark_highlight")

-- Function to parse mark tags and extract info
local function parse_mark_tags(bufnr)
  local result = {}
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for lnum, line in ipairs(lines) do
    local matches = {}
    local pos = 1

    while true do
      -- Find opening tag
      local start_pos, end_open = line:find("<mark[^>]*>", pos)
      if not start_pos then
        break
      end

      -- Find closing tag
      local start_close, end_pos = line:find("</mark>", end_open + 1)
      if not start_close then
        break
      end

      -- Extract full tag, content, and color
      local full_tag = line:sub(start_pos, end_pos)
      local content = line:sub(end_open + 1, start_close - 1)
      local color = full_tag:match("background:%s*([#%w]+)")

      if color and content and #content > 0 then
        -- Process color to remove alpha if present
        local processed_color = color
        local hex_part = processed_color:sub(2)
        if #hex_part > 6 then
          hex_part = hex_part:sub(1, 6)
          processed_color = "#" .. hex_part
        end

        table.insert(matches, {
          start_col = start_pos - 1, -- 0-indexed
          end_col = end_pos, -- 0-indexed, end is exclusive
          content = content,
          color = processed_color,
          full_tag = full_tag,
        })
      end

      pos = end_pos + 1
    end

    if #matches > 0 then
      result[lnum - 1] = matches -- Store as 0-indexed line numbers
    end
  end

  return result
end

-- Check if we're currently in insert mode
local function is_insert_mode()
  return vim.api.nvim_get_mode().mode:match("i") ~= nil
end

-- Function to apply virtual text and highlighting
function M.apply_highlighting(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Clear existing marks
  vim.api.nvim_buf_clear_namespace(bufnr, namespace, 0, -1)

  -- Check if we're in insert mode
  local in_insert = is_insert_mode()

  -- If in insert mode, don't apply any extmarks
  if in_insert then
    return
  end

  -- Parse mark tags
  local parsed_marks = parse_mark_tags(bufnr)

  -- Track created highlight groups
  local highlight_groups = {}

  -- Process each line with marks
  for lnum, matches in pairs(parsed_marks) do
    -- Process in reverse order to avoid position shifting issues
    table.sort(matches, function(a, b)
      return a.start_col > b.start_col
    end)

    for _, match in ipairs(matches) do
      -- Create highlight group for this color if not already created
      local group_name = "MarkHighlight" .. match.color:gsub("#", "")

      if not highlight_groups[group_name] then
        vim.api.nvim_set_hl(0, group_name, {
          fg = "black",
          bg = match.color,
        })
        highlight_groups[group_name] = true
      end

      -- Create an extmark that:
      -- 1. Conceals the original mark tag + content
      -- 2. Replaces it with virtual text with proper highlighting
      vim.api.nvim_buf_set_extmark(bufnr, namespace, lnum, match.start_col, {
        end_col = match.end_col,
        hl_mode = "replace", -- Replace the whole region
        virt_text = { { match.content, group_name } },
        virt_text_pos = "overlay", -- Place virtual text exactly over the concealed text
        conceal = "", -- Conceal the original text
      })
    end
  end
end

-- Function to handle mode changes
function M.handle_mode_change()
  M.apply_highlighting()
end

-- Set up autocommands to apply highlighting
function M.setup()
  local group = vim.api.nvim_create_augroup("MarkHighlight", { clear = true })

  -- Apply highlighting when buffer is loaded or changed
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "TextChangedI" }, {
    group = group,
    callback = function()
      M.apply_highlighting()
    end,
  })

  -- Handle mode changes to show/hide highlighting
  vim.api.nvim_create_autocmd({ "ModeChanged" }, {
    group = group,
    callback = function()
      M.handle_mode_change()
    end,
  })

  -- Apply highlighting to current buffer
  M.apply_highlighting()
end

return M

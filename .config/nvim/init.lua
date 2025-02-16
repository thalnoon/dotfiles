-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
-- require("config.colemak_layout")
require("config.mark_highlight").setup()

vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#ffc971", bold = true })
vim.api.nvim_set_hl(0, "@markup.italic", { fg = "#f38375", italic = true })

local config = vim.fn["gruvbox_material#get_configuration"]()
local palette = vim.fn["gruvbox_material#get_palette"](config.background, config.foreground, config.colors_override)
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1D2021" })
vim.api.nvim_set_hl(0, "@markup.list.marker.star", { fg = "#f38375" })

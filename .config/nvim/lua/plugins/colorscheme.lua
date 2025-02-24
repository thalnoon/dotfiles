return {
  { "rktjmp/lush.nvim" },
  {
    "RRethy/base16-nvim",
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      -- Optionally configure and load the colorscheme
      -- directly inside the plugin declaration.
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_enable_bold = true
      vim.g.gruvbox_material_spell_foreground = "colored"
      vim.g.gruvbox_material_float_style = "dim"
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      vim.g.gruvbox_material_disable_terminal_colors = true
    end,
    overrides = function(colors)
      local theme = colors.theme

      return {
        NormalFloat = { bg = "none" },
        FloatBorder = { bg = "none" },
        FloatTitle = { bg = "none" },

        -- Save a hlgroup with dark background and dimmed foreground
        -- so that you can use it where you still want darker windows.
        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        NormalDark = { fg = theme.ui.fg, bg = theme.ui.bg_m3 },

        -- Popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg },
        Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
        PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        PmenuSbar = { bg = theme.ui.bg_m1 },
        PmenuThumb = { bg = theme.ui.bg_p2 },
      }
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        theme = "lotus",
      })
    end,
  },
  {
    "xero/miasma.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme miasma")
    end,
  },
  {
    "Yazeed1s/oh-lucy.nvim",
    lazy = false,
    priority = 1000,
  },
  {
    "themercorp/themer.lua",
    enabled = false,
    config = function()
      require("themer").setup({
        colorscheme = "gruvbox-material-dark-hard",
      })
    end,
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    opts = {},
    -- overrides = function(colors)
    --   local theme = colors.theme
    --   return {
    --     NormalFloat = { bg = "none" },
    --     FloatBorder = { bg = "none" },
    --     FloatTitle = { bg = "none" },
    --
    --     -- Save a hlgroup with dark background and dimmed foreground
    --     -- so that you can use it where you still want darker windows.
    --     -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
    --     NormalDark = { fg = theme.ui.fg, bg = theme.ui.bg_m3 },
    --
    --     -- Popular plugins that open floats will link to NormalFloat by default;
    --     -- set their background accordingly if you wish to keep them dark and borderless
    --     LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg },
    --     MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg },
    --     Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
    --     PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
    --     PmenuSbar = { bg = theme.ui.bg_m1 },
    --     PmenuThumb = { bg = theme.ui.bg_p2 },
    --   }
    -- end,
  },
  { "cryptomilk/nightcity.nvim", version = false },
  {
    "slugbyte/lackluster.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("lackluster")
      -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
      -- vim.cmd.colorscheme("lackluster-mint")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox-material",
    },
  },
}

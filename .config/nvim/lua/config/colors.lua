local function load_colors()
  local colors = {
    -- Background shades
    bg0_hard = "#1d2021", -- Darkest background
    bg0 = "#282828", -- Default background
    bg1 = "#3c3836", -- Lighter background (for highlights)
    bg2 = "#504945", -- Lighter background (for highlights)
    bg3 = "#665c54", -- Lighter background (for highlights)
    bg4 = "#7c6f64", -- Lighter background (for highlights)

    -- Foreground shades
    fg0 = "#fbf1c7", -- Lightest foreground
    fg1 = "#ebdbb2", -- Default foreground
    fg2 = "#d5c4a1", -- Darker foreground (for highlights)
    fg3 = "#bdae93", -- Darker foreground (for highlights)
    fg4 = "#a89984", -- Darker foreground (for highlights)

    -- Accent colors
    red = "#fb4934",
    green = "#b8bb26",
    yellow = "#fabd2f",
    blue = "#83a598",
    purple = "#d3869b",
    aqua = "#8ec07c",
    orange = "#fe8019",

    -- Muted accent colors
    dark_red = "#cc241d",
    dark_green = "#98971a",
    dark_yellow = "#d79921",
    dark_blue = "#458588",
    dark_purple = "#b16286",
    dark_aqua = "#689d6a",
    dark_orange = "#d65d0e",

    -- Special colors
    gray = "#928374",
    comment_fg = "#a89984",
    gitSigns = {
      add = "#b8bb26",
      change = "#8ec07c",
      delete = "#fb4934",
    },
    diagnostic = {
      error = "#fb4934",
      warn = "#fabd2f",
      info = "#83a598",
      hint = "#8ec07c",
    },
  }
  return colors
end

return {
  load_colors = load_colors,
}

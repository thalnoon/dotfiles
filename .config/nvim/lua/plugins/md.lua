return {

  {
    -- Install markdown preview, use npx if available.
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function(plugin)
      if vim.fn.executable("npx") then
        vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
      else
        vim.cmd([[lazy load markdown-preview.nvim]])
        vim.fn["mkdp#util#install"]()
      end
    end,
    init = function()
      if vim.fn.executable("npx") then
        vim.g.mkdp_filetypes = { "markdown" }
      end
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
  },
  {
    "meanderingprogrammer/render-markdown.nvim",
    enabled = true,
    init = function()
      local colors = require("config.colors").load_colors()

      -- define color variables
      local color1_bg = colors.bright_red
      local color2_bg = colors.bright_green
      local color3_bg = colors.bright_yellow
      local color4_bg = colors.bright_blue
      local color5_bg = colors.bright_purple
      local color6_bg = colors.bright_aqua
      local color_fg = colors.light0

      -- heading colors (when not hovered over), extends through the entire line
      vim.cmd(string.format([[highlight headline1bg guifg=%s guibg=%s]], color_fg, color1_bg))
      vim.cmd(string.format([[highlight headline2bg guifg=%s guibg=%s]], color_fg, color2_bg))
      vim.cmd(string.format([[highlight headline3bg guifg=%s guibg=%s]], color_fg, color3_bg))
      vim.cmd(string.format([[highlight headline4bg guifg=%s guibg=%s]], color_fg, color4_bg))
      vim.cmd(string.format([[highlight headline5bg guifg=%s guibg=%s]], color_fg, color5_bg))
      vim.cmd(string.format([[highlight headline6bg guifg=%s guibg=%s]], color_fg, color6_bg))

      -- highlight for the heading and sign icons (symbol on the left)
      vim.cmd(string.format([[highlight headline1fg cterm=bold gui=bold guifg=%s]], color1_bg))
      vim.cmd(string.format([[highlight headline2fg cterm=bold gui=bold guifg=%s]], color2_bg))
      vim.cmd(string.format([[highlight headline3fg cterm=bold gui=bold guifg=%s]], color3_bg))
      vim.cmd(string.format([[highlight headline4fg cterm=bold gui=bold guifg=%s]], color4_bg))
      vim.cmd(string.format([[highlight headline5fg cterm=bold gui=bold guifg=%s]], color5_bg))
      vim.cmd(string.format([[highlight headline6fg cterm=bold gui=bold guifg=%s]], color6_bg))
    end,
    opts = {
      padding = {
        highlight = " ",
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      indent = {
        enabled = false,
        --skip_heading = true,
        --skip_level = 0,
      },
      bullet = {
        -- turn on / off list bullet rendering
        enabled = false,
        icons = { "" },
      },
      heading = {
        enabled = true,
        position = "inline",
        sign = true,
        icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
        above = 0,
        below = 0,
        backgrounds = {
          "headline1bg",
          "headline2bg",
          "headline3bg",
          "headline4bg",
          "headline5bg",
          "headline6bg",
        },
        -- foregrounds = {
        --   "headline1fg",
        --   "headline2fg",
        --   "headline3fg",
        --   "headline4fg",
        --   "headline5fg",
        --   "headline6fg",
        -- },
      },
    },
    ft = { "markdown", "rmd", "org" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "markdown-toc" } },
  },
  {
    "OXY2DEV/markview.nvim",
    lazy = false, -- Recommended
    -- ft = "markdown" -- If you decide to lazy-load anyway
    enabled = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local presets = require("markview.presets").checkboxes
      require("markview").setup({
        checkboxes = presets.nerd,
        headings = {
          enable = true,
          shift_width = 0,
        },
        list_items = {
          shift_width = 2,
        },
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    enabled = false,
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "markdown-toc" },
        ["markdown.mdx"] = { "markdown-toc" },
        ["typst"] = { "typstfmt" },
      },
    },
  },
  {
    "bullets-vim/bullets.vim",
    config = function()
      -- disable deleting the last empty bullet when pressing <cr> or 'o'
      -- default = 1
      vim.g.bullets_delete_last_bullet_if_empty = 1
      vim.g.bullets_nested_checkboxes = 1
      vim.g.bullets_checkbox_markers = " .oOX"
      -- (optional) add other configurations here
      -- for example, enabling/disabling mappings
      -- vim.g.bullets_set_mappings = 1
    end,
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      -- example mapping to toggle outline
      vim.keymap.set("n", "<leader>ol", "<cmd>Outline<cr>", { desc = "toggle outline" })

      require("outline").setup({
        -- your setup opts here (leave empty to use defaults)
      })
    end,
  },
  {
    "pocco81/highstr.nvim",
    config = function()
      vim.keymap.set("v", "<leader>mha", ":<c-u>HSHighlight 1<cr>", {
        noremap = true,
        silent = true,
      })
      vim.keymap.set("v", "<leader>mhs", ":<c-u>HSHighlight 2<cr>", {
        noremap = true,
        silent = true,
      })
      vim.keymap.set("v", "<leader>mhd", ":<c-u>HSRmHighlight<cr>", {
        noremap = true,
        silent = true,
      })
      vim.keymap.set("v", "<leader>mhf", ":<c-u>HSHighlight 3<cr>", {
        noremap = true,
        silent = true,
      })
      vim.keymap.set("v", "<leader>mhj", ":<c-u>HSHighlight 4<cr>", {
        noremap = true,
        silent = true,
      })
      vim.keymap.set("v", "<leader>mhk", ":<c-u>HSHighlight 5<cr>", {
        noremap = true,
        silent = true,
      })
      vim.keymap.set("v", "<leader>mhl", ":<c-u>HSHighlight 6<CR>", {
        noremap = true,
        silent = true,
      })
    end,
  },
  {
    "dhruvasagar/vim-table-mode",
    enabled = true,
  },
  {
    "nvim-orgmode/orgmode",
    enabled = false,
    event = "VeryLazy",
    ft = { "org" },
    config = function()
      -- Setup orgmode
      require("orgmode").setup({
        org_default_notes_file = "R:/Documents/roam",
        org_indent_mode = true,
        org_startup_indented = true,
        org_id_link_to_org_use_id = true,
      })

      -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
      -- add ~org~ to ignore_install
      -- require('nvim-treesitter.configs').setup({
      --   ensure_installed = 'all',
      --   ignore_install = { 'org' },
      -- })
    end,
  },
  {
    "chipsenkbeil/org-roam.nvim",
    enabled = false,
    tag = "0.1.1",
    dependencies = {
      {
        "nvim-orgmode/orgmode",
        tag = "0.3.7",
      },
    },
    config = function()
      require("org-roam").setup({
        directory = "R:/Documents/roam",
      })
    end,
  },
  {
    "jakewvincent/mkdnflow.nvim",
    enabled = true,
    config = function()
      require("mkdnflow").setup({
        -- Config goes here; leave blank for defaults
        links = {
          style = "wiki",
          name_is_source = true,
        },
        mappings = {
          MkdnEnter = { { "n", "v" }, "<C-CR>" },
          MkdnNextHeading = { "n", "ghn" },
          MkdnPrevHeading = { "n", "ghp" },
          MkdnDestroyLink = false,
          MkdnTagSpan = false,
          MkdnToggleToDo = { { "n", "v" }, "<CR>" },
        },
      })
    end,
  },
}

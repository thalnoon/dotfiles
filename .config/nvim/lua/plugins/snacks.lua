return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  keys = {
    { ",c", LazyVim.pick.config_files(), desc = "Find Config File" },
    -- { ",c", LazyVim.pick.picker({ cwd = "~/dotfiles/.config/nvim" }), desc = "Find Config File" },
    -- {
    --   ",c",
    --   function()
    --     Snacks.picker.files({ cwd = "~/dotfiles/.config/nvim/" })
    --   end,
    --   desc = "Find Config File",
    -- },
    {
      ",,",
      LazyVim.pick("files"),
      desc = "Find Files - Root",
    },
    {
      ",f",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },
    {
      ",s",
      function()
        Snacks.picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      ",b",
      function()
        Snacks.picker.buffers({
          -- I always want my buffers picker to start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } },
          },
          -- In case you want to override the layout for this keymap
          -- layout = "ivy",
        })
      end,
      desc = "[P]Snacks picker buffers",
    },
  },
  opts = {
    image = {
      doc = {
        inline = false,
      },
    },
    lazygit = {},
    terminal = {},
    dashboard = {
      enabled = true,
    },
    picker = {
      layout = {
        cycle = false,
        preset = "ivy",
      },
      matcher = {
        frequency = true,
      },
      layouts = {
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.5,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.5, border = "left" },
            },
          },
        },
      },
      win = {
        input = {
          keys = {
            ["<CR>"] = { "confirm", mode = { "n", "i" } },
            ["<C-y>"] = { "confirm", mode = { "n", "i" } },
          },
        },
      },
    },
  },
}

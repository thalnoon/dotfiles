return {
  "echasnovski/mini.files",
  opts = {
    mappings = {
      close = "q",
      -- Use this if you want to open several files
      go_in = "<Right>",
      -- This opens the file, but quits out of mini.files (default L)
      go_in_plus = "<CR>",
      -- I swapped the following 2 (default go_out: h)
      -- go_out_plus: when you go out, it shows you only 1 item to the right
      -- go_out: shows you all the items to the right
      go_out = "<Left>",
      go_out_plus = "h",
      -- Default <BS>
      reset = ",",
      -- Default @
      reveal_cwd = ".",
      show_help = "g?",
      -- Default =
      synchronize = "-",
      trim_left = "<",
      trim_right = ">",
    },
    options = {
      -- Whether to use for editing directories
      -- Disabled by default in LazyVim because neo-tree is used for that
      use_as_default_explorer = true,
      -- If set to false, files are moved to the trash directory
      -- To get this dir run :echo stdpath('data')
      -- ~/.local/share/neobean/mini.files/trash
      permanent_delete = true,
    },
  },
}

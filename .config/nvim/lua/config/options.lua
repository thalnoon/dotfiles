-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Text formatting for markdown
--vim.opt.formatlistpat = "^\\s*\\d\\+\\.\\s\\+\\|^\\s*[-*+]\\s\\+\\|^\\[^\\ze[^\\]]\\+\\]:"

vim.cmd("let g:netrw_liststyle = 3")
vim.api.nvim_create_user_command("W", ":w !SUDO_ASKPASS=/usr/bin/ksshaskpass sudo -A tee % > /dev/null", {})
vim.api.nvim_create_user_command("Q", ":q!", {})
vim.g.maplocalleader = ","
local opt = vim.opt
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

vim.g.oh_lucy_transparent_background = false

-- vim.o.shell = '"C:\\Program Files\\PowerShell\\7\\pwsh.exe"'
-- vim.o.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command 2>$null"
-- vim.o.shellredir = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.o.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
-- vim.o.shellquote = ""
-- vim.o.shellxquote = ""

vim.o.shell = "zsh"
vim.api.nvim_command("autocmd TermOpen * startinsert") -- starts in insert mode
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber") -- no numbers
vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no") -- no sign column

-- Automatically start tmux in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    if not os.getenv("TMUX") then
      -- Start tmux automatically if not already inside a tmux session
      vim.fn.chansend(vim.b.terminal_job_id, "tmux\n")
    end
  end,
})

-- vim.o.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
-- vim.o.shellcmdflag =
--   [[-NoLogo -ExecutionPolicy RemoteSigned -Command "Remove-Alias -Force -ErrorAction SilentlyContinue tee;"]]
-- vim.o.shellredir = [[2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode]]
-- vim.o.shellpipe = [[2>&1 | %%{ "$_" } | tee %s; exit $LastExitCode]]
-- vim.o.shellquote = ""
-- vim.o.shellxquote = ""
-- line wrapping
opt.wrap = false -- disable line wrapping

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono NFP:h15" -- text below applies for VimScript
  vim.g.neovide_scale_factor = 1.0
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)
end

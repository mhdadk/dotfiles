-- Windows-specific settings. This file is only needed on Windows; Linux runs
-- init.lua alone without it. It is sourced automatically at the end of init.lua
-- when Neovim detects it is running on Windows, so it should never be loaded
-- manually. Keep this file focused on things that only make sense on Windows;
-- shared config lives in init.lua so it stays platform-agnostic.

-- Use PowerShell instead of cmd.exe as the default shell for :! commands, :terminal,
-- and anything else that shells out. The flags below replicate a clean PS session:
--   -NoLogo        suppress the copyright banner
--   -NoProfile     skip $PROFILE so startup is fast and predictable
--   -ExecutionPolicy RemoteSigned  allow local scripts without full bypass
-- shellxquote/shellquote are cleared because PowerShell doesn't need the extra
-- quoting wrappers that cmd.exe requires, and shellpipe/shellredir redirect
-- output through Out-File so Neovim gets UTF-8 instead of the system codepage.
-- Use pwsh (PowerShell 7) not powershell (Windows PowerShell 5). They have
-- separate profile locations: pwsh loads from Documents\PowerShell\, while
-- powershell loads from Documents\WindowsPowerShell\. The oh-my-posh setup
-- lives in the PowerShell 7 profile, so pwsh must be used consistently.
vim.opt.shell = "pwsh"
vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
vim.opt.shellxquote = ""
vim.opt.shellquote = ""
vim.opt.shellpipe = "| Out-File -Encoding UTF8 %s"
vim.opt.shellredir = "| Out-File -Encoding UTF8 %s"

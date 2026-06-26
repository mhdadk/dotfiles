# dotfiles

Personal configuration files for shells, Neovim, and prompt theming across
Linux (Debian) and Windows.

## Contents

| File | Description |
| ---- | ----------- |
| [`.bashrc`](.bashrc) | Bash startup file for non-login shells (Linux), based on the Debian default with an `eza` `ls` alias and the oh-my-posh prompt. |
| [`bashrc.mine.sh`](bashrc.mine.sh) | Personal Bash overrides (Linux): editor, aliases, `pip` mirror, and fzf integration, kept separate from the stock `.bashrc`. |
| [`.gitconfig`](.gitconfig) | Global Git configuration: user identity, aliases, LFS filters, `nvim` editor, and [delta](https://github.com/dandavison/delta) as the pager. |
| [`init.lua`](init.lua) | Neovim configuration for Linux, managed by [lazy.nvim](https://github.com/folke/lazy.nvim) (LSP, completion, Treesitter, file tree, fuzzy finding, custom keymaps). |
| [`init-windows.lua`](init-windows.lua) | Windows variant of `init.lua`, using PowerShell as Neovim's shell. |
| [`Microsoft.PowerShell_profile.ps1`](Microsoft.PowerShell_profile.ps1) | PowerShell profile for Windows Terminal: oh-my-posh prompt, PSReadLine settings, and an [lsd](https://github.com/lsd-rs/lsd)-based `ls`. |
| [`paradox_modified.omp.json`](paradox_modified.omp.json) | Custom [oh-my-posh](https://ohmyposh.dev/) prompt theme (a modified `paradox`), shared by the Bash and PowerShell prompts. |

## Notes

- `.bashrc` and `bashrc.mine.sh` are both Bash configs: `.bashrc` is the main
  startup file, while `bashrc.mine.sh` holds personal additions intended to be
  sourced from a `~/.bashrc.d/`-style drop-in directory.
- `init.lua` and `init-windows.lua` differ only in a few platform-specific
  settings (shell, Treesitter parser list, session restore).

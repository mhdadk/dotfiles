# dotfiles

Personal configuration files for shells, Neovim, the kitty terminal, and
prompt theming across Linux (Debian) and Windows.

## Contents

| File | Description |
| ---- | ----------- |
| [`.bashrc`](.bashrc) | Bash startup file for non-login shells (Linux), based on the Debian default with an `eza` `ls` alias and the oh-my-posh prompt. |
| [`bashrc.mine.sh`](bashrc.mine.sh) | Personal Bash overrides (Linux): editor, aliases, `pip` mirror, and fzf integration, kept separate from the stock `.bashrc`. |
| [`.gitconfig`](.gitconfig) | Global Git configuration: user identity, aliases, LFS filters, `nvim` editor, and [delta](https://github.com/dandavison/delta) as the pager. |
| [`init.lua`](init.lua) | Neovim configuration, managed by [lazy.nvim](https://github.com/folke/lazy.nvim) (LSP, completion, Treesitter, file tree, fuzzy finding, custom keymaps). Works standalone on Linux; on Windows it automatically loads `windows.lua`. |
| [`windows.lua`](windows.lua) | Windows-only Neovim additions sourced by `init.lua` on Windows: sets PowerShell as the shell for `:terminal` and shell commands. |
| [`Microsoft.PowerShell_profile.ps1`](Microsoft.PowerShell_profile.ps1) | PowerShell profile for Windows Terminal: oh-my-posh prompt, PSReadLine settings, and an [lsd](https://github.com/lsd-rs/lsd)-based `ls`. |
| [`paradox_modified.omp.json`](paradox_modified.omp.json) | Custom [oh-my-posh](https://ohmyposh.dev/) prompt theme (a modified `paradox`), shared by the Bash and PowerShell prompts. |
| [`kitty/kitty.conf`](kitty/kitty.conf) | [kitty](https://sw.kovidgoyal.net/kitty/) terminal config: Nerd Font with ligatures, font-size zoom keys, remote control, and sensible defaults. |
| [`kitty/current-theme.conf`](kitty/current-theme.conf) | kitty color theme ([Dracula](https://draculatheme.com/)), included by `kitty.conf`. |

## Notes

- `.bashrc` and `bashrc.mine.sh` are both Bash configs: `.bashrc` is the main
  startup file, while `bashrc.mine.sh` holds personal additions intended to be
  sourced from a `~/.bashrc.d/`-style drop-in directory.
- `init.lua` is the single Neovim entry point on both platforms. `windows.lua`
  extends it with Windows-specific settings and is loaded automatically — it does
  not need to be placed in the Neovim config directory on Linux.

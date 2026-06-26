# dotfiles

Personal configuration files for shells, Neovim, and prompt theming across
Linux (Debian) and Windows.

## Contents

| File | Description |
| ---- | ----------- |
| [`.bashrc`](.bashrc) | Bash startup file for non-login shells. Built on the Debian default: history settings, the colored prompt, `ls`/`grep` color aliases, and bash completion. Customized to alias `ls` to `eza`, initialize the [oh-my-posh](https://ohmyposh.dev/) prompt with the `paradox_modified` theme, and source the Cargo environment. |
| [`bashrc.mine.sh`](bashrc.mine.sh) | Personal Bash overrides kept separate from the stock `.bashrc`. Adds `~/.local/bin` to `PATH`, the oh-my-posh prompt, an `eza`-based `ls` alias, and `bat`/`fd` aliases for the Debian-renamed binaries. Sets `nvim` as `EDITOR`/`VISUAL`, defines `amp`/`claude` launcher aliases, points `pip` at an internal PyPI mirror, and wires up fzf shell integration (key bindings, completion, and `fd`/`bat` previews). |
| [`.gitconfig`](.gitconfig) | Global Git configuration. Sets user identity, short aliases (`co`, `br`, `c`, `s`, `a`, `p`), Git LFS filters, `nvim` as the editor, `input` line-ending normalization, and [delta](https://github.com/dandavison/delta) as the pager with line numbers, hyperlinks, and `diff3` merge conflict style. |
| [`init.lua`](init.lua) | Neovim configuration for Linux. Bootstraps the [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager and configures LSP (mason + nvim-lspconfig), completion (nvim-cmp), Treesitter, a file tree (nvim-tree), fuzzy finding (fzf-lua), bufferline, which-key, and toggleterm. Includes custom keymaps (space leader, `jk`/`kj` to exit insert mode, `Ctrl-h/j/k/l` split navigation) and session auto-restore via persistence.nvim. |
| [`init-windows.lua`](init-windows.lua) | Windows variant of `init.lua`. Same base configuration, but sets PowerShell as Neovim's shell, drops the Treesitter `ensure_installed` list and the persistence.nvim session auto-restore, and omits the lightline statusline/tabline tweak. |
| [`Microsoft.PowerShell_profile.ps1`](Microsoft.PowerShell_profile.ps1) | PowerShell profile for Windows Terminal. Initializes the oh-my-posh `paradox_modified` prompt, configures PSReadLine (Tab completion, no bell), disables the virtualenv prompt prefix, and redefines `ls` to use [lsd](https://github.com/lsd-rs/lsd) with a custom date/column format. |
| [`paradox_modified.omp.json`](paradox_modified.omp.json) | Custom [oh-my-posh](https://ohmyposh.dev/) prompt theme (a modified `paradox`). A Powerline-style prompt with root, session (`user@host`), path, Git branch, Python/venv, and exit-status segments, plus a second-line input arrow. Shared by both the Bash and PowerShell prompts. |

## Notes

- `.bashrc` and `bashrc.mine.sh` are both Bash configs: `.bashrc` is the main
  startup file, while `bashrc.mine.sh` holds personal additions intended to be
  sourced from a `~/.bashrc.d/`-style drop-in directory.
- `init.lua` and `init-windows.lua` differ only in a few platform-specific
  settings (shell, Treesitter parser list, session restore).

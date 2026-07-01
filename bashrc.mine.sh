# nvim path
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
eval "$(oh-my-posh init bash --config ~/.cache/oh-my-posh/themes/paradox_modified.omp.json)"
alias ls='eza --long --time-style="+%d-%b-%y %I:%M %p" --no-user --group-directories-first --sort=name'
alias bat="batcat"
alias fd="fdfind"

# Use bat as pager for "--help" output whenever possible
# export PAGER='batcat'

# Fix Simulink scaling in MATLAB
# https://www.mathworks.com/matlabcentral/answers/2178210-simulink-is-too-small-on-my-high-dpi-display-in-linux#answer_1567641
# unset QT_SCREEN_SCALE_FACTORS
# unset QT_AUTO_SCREEN_SCALE_FACTOR
# unset QT_ENABLE_HIGHDPI_SCALING

# amp and claude code shortcuts
alias amp='devai launch -- amp'
alias claude='devai launch -- claude'
alias claude_mw='mw devai launch -- claude'

# Set default editor for amp and claude code
export VISUAL="$(which nvim)"
export EDITOR=$(which nvim)

# Use internal PyPI mirror for pip
export PIP_INDEX_URL=https://mw-python-repository.mathworks.com/artifactory/api/pypi/pypi-repos/simple

# fzf shell integration (key bindings + completion)
# Provides Ctrl-R (history), Ctrl-T (paste file paths), Alt-C (cd into dir),
# and the **<Tab> fuzzy-completion trigger.
# Note: for fzf >= 0.48 these two lines can be replaced by: eval "$(fzf --bash)"
if command -v fzf >/dev/null 2>&1; then
    [ -r /usr/share/doc/fzf/examples/key-bindings.bash ] && \
        source /usr/share/doc/fzf/examples/key-bindings.bash
    [ -r /usr/share/bash-completion/completions/fzf ] && \
        source /usr/share/bash-completion/completions/fzf

    # Use fd (respects .gitignore, skips .git) as the default source command
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'

    # Sensible defaults + previews (batcat for files, ls for dirs)
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"
    export FZF_CTRL_T_OPTS="--preview 'batcat --color=always --style=numbers --line-range=:200 {}'"
    export FZF_ALT_C_OPTS="--preview 'ls -la {}'"
fi

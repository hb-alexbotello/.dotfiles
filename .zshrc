# Set default PATH for usual binary locations
export PATH="~/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

# Add all pyenv python's into the PATH
export PATH="$(pyenv which python | xargs dirname):$PATH"
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"

[[ -n "$DISPLAY" && "$TERM" = "xterm" ]] && export TERM=xterm-256color

# Needed for Poetry
export SHELL=/bin/zsh

alias vim='nvim'
alias tf='terraform'
alias python='python3'

# Run Kitty with a specified session
alias kitty='kitty --session ~/.config/kitty/startup.conf'

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# fzf alias to quickly switch to a directory
alias f='cd $(fd --type directory --hidden | fzf)'

# starship prompt
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

export GOPATH="$HOME/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

# auto suggestions for zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Setup bindings for both smkx and rmkx key variants
# Home
bindkey '\e[H'  beginning-of-line
bindkey '\eOH'  beginning-of-line
# End
bindkey '\e[F'  end-of-line
bindkey '\eOF'  end-of-line
# Up
bindkey '\e[A' up-line-or-search
bindkey '\eOA' up-line-or-search
# Down
bindkey '\e[B' down-line-or-search
bindkey '\eOB' down-line-or-search

# Set default PATH for usual binary locations
export PATH="~/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin:$PATH"

# Add all pyenv python's into the PATH
export PATH="$(pyenv which python | xargs dirname):$PATH"
export TERM=xterm-256color

# Needed for Poetry
export SHELL=/bin/zsh

alias vim='nvim'
alias tf='terraform'
alias python='python3'

# Run Kitty with a specified session
alias kitty='kitty --session ~/.config/kitty/startup.conf'

# auto suggestions for zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

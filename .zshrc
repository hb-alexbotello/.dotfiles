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
alias f='cd $(fd --type directory --hidden --exclude .git --exclude node_modules --exclude .go --exclude Library --exclude .pyenv | fzf)'

alias zbt='zig build test'
alias jira='acli jira'

alias cc='claude --dangerously-skip-permissions --continue'

# starship prompt
export STARSHIP_CONFIG=~/.config/starship.toml
eval "$(starship init zsh)"

# direnv to automatically load Nix Flakes
eval "$(direnv hook zsh)"

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

# git worktree automation
wt() {
    # Check if feature name is provided
    if [ -z "$1" ]; then
        echo "Error: Feature name is required"
        echo "Usage: wt <FEATURE_NAME>"
        return 1
    fi
    
    # Check if we're in a git repository
    if [ ! -d ".git" ]; then
        echo "Error: Not in a git repository. Please run this command from the root of a git repository."
        return 1
    fi
    
    local feature_name="$1"
    local current_dir=$(basename "$(pwd)")
    local worktree_base_dir="../${current_dir}_worktrees"
    local worktree_path="${worktree_base_dir}/${feature_name}"
    
    # Create worktree base directory if it doesn't exist (idempotent)
    if [ ! -d "$worktree_base_dir" ]; then
        mkdir -p "$worktree_base_dir"
        echo "Created worktree directory: $worktree_base_dir"
    else
        echo "Using existing worktree directory: $worktree_base_dir"
    fi
    
    # Check if worktree already exists
    if [ -d "$worktree_path" ]; then
        echo "Error: Worktree '$feature_name' already exists at $worktree_path"
        return 1
    fi
    
    # Create the worktree and branch
    echo "Creating worktree and branch: $feature_name"
    if git worktree add "$worktree_path" -b "$feature_name"; then
        echo "✅ Successfully created worktree: $worktree_path"
        
        # Change to the worktree directory
        cd "$worktree_path"
        echo "📁 Switched to worktree directory: $(pwd)"
        
        # Show git status to confirm everything is working
        echo "📊 Git status:"
        git status --short
    else
        echo "❌ Failed to create worktree"
        return 1
    fi
}

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

eval "$(pyenv init -)"

set -o vi

if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi


function set_virtualenv () {
   if test -z "$VIRTUAL_ENV" ; then
       PYTHON_VIRTUALENV=""
   else
	#MODIFIED_VENV="$( echo ${VIRTUAL_ENV} | rev | cut -d'-' -f 1)"
	PYTHON_VIRTUALENV="${BLUE}(`basename \"$VIRTUAL_ENV\"`)${COLOR_NONE} "
   fi
}
set_virtualenv

orange=$(tput setaf 166);
yellow=$(tput setaf 227);
green=$(tput setaf 118);
white=$(tput setaf 16);
bold=$(tput bold);
reset=$(tput sgr0);

PS1="\[${bold}\]\n";
PS1="\[${PYTHON_VIRTUALENV}\]";
PS1+="\u@\h ";
PS1+="\[${yellow}\]\w";
PS1+="\[${reset}\]> ";
export PS1;


export GREP_OPTIONS='--color=always'
export GREP_COLOR='1;36'

alias dc="docker-compose"
alias date="gdate"
source ~/.config/bashlog/bashlog.sh

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

function logf () {
   if [ $# -eq 0 ]; then
    echo "No search term given"
   else
    term=$1
    grep -s "${term}" ~/Notes/{*,.*}
   fi
}

set -o vi

alias tmux="TERM=screen-256color-bce tmux -2"
source "$HOME/.bashrc"

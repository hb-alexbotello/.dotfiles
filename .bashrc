export PATH="$HOME/Library/Python/3.8/bin:/opt/homebrew/bin:$PATH"
export TERM=screen-256color
# export LDFLAGS="-L/home/linuxbrew/.linuxbrew/opt/libnsl/lib"
# export CPPFLAGS="-I/home/linuxbrew/.linuxbrew/opt/libnsl/include"
# export PKG_CONFIG_PATH="/home/linuxbrew/.linuxbrew/opt/libnsl/lib/pkgconfig"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

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
# yellow=$(tput setaf 227);
purple=$(tput setaf 135);
green=$(tput setaf 118);
white=$(tput setaf 16);
bold=$(tput bold);
reset=$(tput sgr0);

PS1="\[${bold}\]\n";
PS1="\[${PYTHON_VIRTUALENV}\]";
PS1+="\u@\h ";
# PS1+="\[${yellow}\]\w";
PS1+="\[${purple}\]\w";
PS1+="\[${reset}\]> ";
export PS1;



alias vim='nvim'
alias grep='grep --color=always -i'
alias dc="docker-compose"
alias date="gdate"
alias tf="terraform"
export GREP_COLOR='1;36'

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

set -o vi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
alias tmux="TERM=screen-256color-bce tmux -2"
# export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -l ""'

export GOPATH="$HOME/.go"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"


## FUNCTIONS
function get_bea () {
	if [ -z "$2" ]
	then
		HOST="https://bea-crm.thb.nu"
		TOKEN='2476d672a2767b9d008904544e3486e109d001d9'
	else
		HOST="https://bea-crm.thb.sh"
		TOKEN='fe1ed8844ef6c172c38faa86ff9f215589aa2347'
	fi
	AUTH_HEADER="Authorization: Token $TOKEN"
	URL=$(echo $1 | sed 's/ /%20/g')
	echo $URL
	ROUTE="$HOST$URL"

	curl -s -H "$AUTH_HEADER" -L -X GET $ROUTE > d.json
}

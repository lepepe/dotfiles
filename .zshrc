# Path to your oh-my-zsh installation.
ZSH=/usr/share/oh-my-zsh/

export TERM="xterm-256color"
export ZSH=/usr/share/oh-my-zsh

#ZSH_THEME="powerlevel9k/powerlevel9k"
ZSH_THEME="robbyrussell"

plugins=(archlinux 
	asdf 
	bundler 
	docker 
	jsontools 
	vscode 
	web-search 
	tig 
	gitfast 
	colored-man-pages 
	colorize 
	command-not-found 
	cp 
	dirhistory 
	sudo 
	)
# /!\ zsh-syntax-highlighting and then zsh-autosuggestions must be at the end

source $ZSH/oh-my-zsh.sh

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[cursor]='bold'

ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green,bold'

rule () {
	print -Pn '%F{blue}'
	local columns=$(tput cols)
	for ((i=1; i<=columns; i++)); do
	   printf "\u2588"
	done
	print -P '%f'
}

function _my_clear() {
	echo
	rule
	zle clear-screen
}
zle -N _my_clear
bindkey '^l' _my_clear

# Ctrl-O opens zsh at the current location, and on exit, cd into ranger's last location.
ranger-cd() {
	tempfile=$(mktemp)
	ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
	test -f "$tempfile" &&
	if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
	cd -- "$(cat "$tempfile")"
	fi
	rm -f -- "$tempfile"
	# hacky way of transferring over previous command and updating the screen
	VISUAL=true zle edit-command-line
}
zle -N ranger-cd
bindkey '^o' ranger-cd

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
cat ~/.cache/wal/sequences

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh

# Ruby ENV
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export RUBYOPT='-W:no-deprecated -W:no-experimental'

# Source configs aliases
alias v='nvim'
alias sv='sudo nvim'
alias p='pandoc'
alias m='mpv'
alias r='ranger'
alias sr='sudo ranger'
alias lfs='sudo lf'
alias trc='transmission-remote-cli'
alias trss='transmission-rss'
alias xup='xrdb .Xresources'
alias pman='sudo pacman'
alias pip='sudo pip'
alias sn='sncli'
alias td='calcurse'
alias sptd='systemctl --user enable spotifyd.service'
# Custom sripts
alias sshrm='~/.local/bin/scripts/sshfs-remote-mount.sh'
alias dossh='~/.local/bin/scripts/dossh.sh'
alias lssh='~/.local/bin/scripts/lssh.sh'
alias mssql='~/.local/bin/scripts/mssql.sh'

#alias ls='ls-icons -lah --color=auto'
alias ls='exa -lah'
alias grep='grep --color=auto'

alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh 2>/dev/null

neofetch
eval "$(starship init zsh)"

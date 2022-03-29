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
alias firep='~/.local/bin/scripts/firep.sh'
alias rdp='~/.local/bin/scripts/rdp.sh'

#alias ls='ls-icons -lah --color=auto'
alias ls='exa -lah'
alias grep='grep --color=auto'

alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
cat ~/.cache/wal/sequences

neofetch
starship init fish | source

set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/shims $PATH
set -x PATH $PYENV_ROOT/bin $PATH

if which pyenv 1>/dev/null 2>&1
    pyenv init - | source
end


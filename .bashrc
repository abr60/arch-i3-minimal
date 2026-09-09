# arch-i3-minimal .bashrc — clean minimal
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lha'
alias ..='cd ..'
alias v='nvim 2>/dev/null || vim'
alias off='systemctl poweroff'
alias reb='systemctl reboot'

PS1='[\u@\h \W]\$ '

export EDITOR=nano
export TERMINAL=alacritty
export PAGER=less

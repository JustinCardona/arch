#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Aliases
alias clean='paru --noconfirm -Sc; rm -r ~/Downloads/*'
alias todo='cat ~/School/toDoList'

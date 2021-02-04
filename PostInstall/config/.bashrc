#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Aliases
alias ls='ls --color=auto'
alias la='ls -al --color=auto'
alias clean='paru --noconfirm -c; paru --noconfirm -Sc; rm -r ~/Downloads/*'
alias todo='cat ~/School/toDoList'
alias con='source /opt/anaconda/bin/activate root'
alias coff='source /opt/anaconda/bin/deactivate root'

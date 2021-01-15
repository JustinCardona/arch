#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias clean='yay --noconfirm -Yc; yay --noconfirm -Sc; rm -r ~/Downloads/*'
alias todo='cat ~/School/toDoList'

PS1='[\u@\h \W]\$ '

# Conda stuff
export PATH="/opt/anaconda/bin:$PATH"

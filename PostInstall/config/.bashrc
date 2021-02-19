#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

# Aliases
alias ls='ls --color=auto'
alias la='ls -al --color=auto'
alias clean='yay --noconfirm -Yc; yay --noconfirm -Sc; sudo journalctl --vacuum-time=1weeks;rm -rf ~/Downloads/*; rm -rf ~/.cache/*'
alias todo='cat ~/School/toDoList'
alias sync='git add .;git commit; git pull;git push'

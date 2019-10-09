# 
# 
# Standard set of tweaks and aliases 
#
#
##################################################################

##################################################################
# Basics
##################################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export EDITOR=vi

# Get system type 
export system=$(uname -s)

##################################################################
# Basic aliases
##################################################################

alias vi=vim
alias ll="ls -lh"
alias llt="ls -ltrh"


# Load additional aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

##################################################################
# Docker specific
##################################################################

if [ -x $(which docker) ]; then
alias ds='docker stats $(docker ps --format={{.Names}})'
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias dpa="docker ps -a"
alias dex="docker exec -i -t"

complete -F _docker_exec dex 
complete -F _docker_exec dip

fi

##################################################################
# Linux specific
##################################################################

if [ $system = "Linux" ]; then

# Bash completion
if [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi


# End of Linux specific
fi

##################################################################
# MacOS specific
##################################################################

if [ $system = "Darwin" ];then 

#Bash completition
if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
fi

#iTerm2 integration
if [ -f ${HOME}/.iterm2_shell_integration.bash ]; then 
   source ${HOME}/.iterm2_shell_integration.bash
fi
#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# ~/bin to $PATH
export PATH=~/bin:$PATH
# End of MacOs Specific
fi


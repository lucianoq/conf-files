#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

SAVEHIST=10000 # Number of entries
HISTSIZE=10000
export HISTCONTROL=ignoreboth:erasedups

shopt -s histappend
export JAVA_HOME=/usr/lib/jvm/default-runtime
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
export CHROME_BIN="/usr/bin/google-chrome-stable"
export GOPATH=$HOME/dev/gopath/

# set PATH so it includes user's private bin if it exists
#if [ -d "$HOME/bin" ] ; then
#    export PATH="$HOME/bin:$PATH"
#fi

#Android PATHS
#export PATH=$PATH:~/.opt/sdk/tools:~/.opt/sdk/platform-tools
export PATH=$PATH:~/.opt/bin
export PATH=$PATH:~/.opt/appengine-python-sdk


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# These set up/down to do the history searching
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS=' -R '
export LESS_TERMCAP_me=$(printf '\e[0m')
export LESS_TERMCAP_se=$(printf '\e[0m')
export LESS_TERMCAP_ue=$(printf '\e[0m')
export LESS_TERMCAP_mb=$(printf '\e[1;32m')
export LESS_TERMCAP_md=$(printf '\e[1;34m')
export LESS_TERMCAP_us=$(printf '\e[1;32m')
export LESS_TERMCAP_so=$(printf '\e[1;44;1m')

# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS1="\[\033[36m\]\u\[\033[m\]:\[\033[33;1m\]\w\[\033[m\]\$ "
    #PS1="\n┌ \[\033[1;31m\][\t] \[\033[0;94m\]\u@\h\[\033[m\]:\[\e[1;33m\]\w\[\e[m\]\n└ \$ "
    #PS1="\n\[\033[1;31m\][\t] \[\033[0;94m\]\u@\h\[\033[m\]: \[\e[1;33m\]\w\[\e[m\]\n→ "
    PS1="\n\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi) \[\033[0;94m\]\u\[\033[m\]:\[\e[1;33m\]\w\[\e[m\] → "
else
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='[\t] \u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


if [ -f /usr/share/bash-completion/bash-completion ]; then
  . /usr/share/bash_completion/bash_completion
fi


# The next line updates PATH for the Google Cloud SDK.
source '/home/lusio/.opt/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/home/lusio/.opt/google-cloud-sdk/completion.bash.inc'

if [ $TERM != "screen-256color" ]; then 
    exec tmux
fi

echo "lusio's bash settings loaded"

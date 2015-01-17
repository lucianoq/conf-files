#!/bin/bash
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=always'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'    
    alias grep='grep --color'
    alias grepi='grep --color -i'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Directory & File Management
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias cd..='cd ..'
alias mkdir='mkdir -p'
#alias less='less --raw-control-chars'

alias ..='cd ..'
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

alias setclip='xclip -selection clipboard'
alias getclip='xclip -selection clipboard -o'

# show sorted directory sizes for all directories
alias duh='du -s ~/* | cut -f1 | spark && du -sch ~/*'
alias duhere='du -s ./* | cut -f1 | spark && du -sch ./*'
alias dua='du --max-depth=1 ~ | cut -f1 | spark && du -ch --max-depth=1 ~'
alias dfh='df -h'

# system monitoring & updating
alias dpkgl="dpkg -l | grep"
alias psg='ps auxf | grep'
alias local_ports='sudo nmap -sT -O localhost'
alias traffic="sudo tcpdump -i wlan0 -n -s0 -e"
alias adga="adg && sudo npm update -g && antigen update && vundle-update && rvm use 2.0.0@global && gemup && gem cleanup && cabal-upgrade"
alias acr="aac && sudo $apt_pref -y autoremove"
alias aps="apt-cache search"
alias apsw="apt-cache show"

#alias up='sudo apt-get -y update && sudo apt-get -y upgrade'
alias up='sudo pacman -Syu'

# When using sudo, use alias expansion (otherwise sudo ignores your aliases)
alias sudo='sudo '

alias say='espeak -v it 2> /dev/null'

function ged() {
	gedit > /dev/null 2> /dev/null "$@" &
}

alias temp="sensors | grep -e 'Core 0' | sed -e 's/^.*\(\+.*C\)\ .*$/\1/'"
#alias lamp='sudo service mysql start && sudo service apache2 start'

alias kraken="curl -s 0 https://api.kraken.com/0/public/Ticker?pair=XXBTZEUR | jq '.result.XXBTZEUR.a[0]' | tr -d '\"' | sed 's/^.*$/€\ \0/'"

alias C='set -f -B; Cf '
function Cf () { echo  "$@" | tr -d ', \042-\047' | bc -l; set +f; };

## Process/System functions

#helper for pp
function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

#do i own this process?
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

#install packages and log
#function install()
# {
#  packages=$@
#  sudo apt-get install ${=packages} && echo "$packages" >> ~/.installd
# }

#function add-repo()
# {
#  repos=$@
#  sudo add-apt-repository -y ppa:${=repos} && echo "sudo add-apt-repository -y ppa:$repos" >> ~/.installd
#  sudo apt-get update
#}

#colorize man output ... http://www.cyberciti.biz/faq/linux-unix-colored-man-pages-with-less-command/
#man() {
#  env \
#    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
#    LESS_TERMCAP_md=$(printf "\e[1;31m") \
#    LESS_TERMCAP_me=$(printf "\e[0m") \
#    LESS_TERMCAP_se=$(printf "\e[0m") \
#    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
#    LESS_TERMCAP_ue=$(printf "\e[0m") \
#    LESS_TERMCAP_us=$(printf "\e[1;32m") \
#    man "$@"
#}

## Networking functions
##
#get my ip
function myip-local()
{
  IP=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`;
  echo $IP
}

function myip-global()
{
  dig +short myip.opendns.com @resolver1.opendns.com
}

function myips()
{
  echo -e "\nMy Local IPs:\n\033[1;32m`myip-local`\033[m"
  echo -e "\nMy External IPs:\n\033[1;32m`myip-global`${NC}\033[m\n"
}



#summarize current network situation
function ii()
{
  echo -e "\nYou are logged on ${BLUE}$HOSTNAME${NC}"
  echo -e "\nAdditionnal information:$NC " ; uname -a
  echo -e "\n${RED}Users logged on:$NC " ; w -h
  echo -e "\n${RED}Current date :$NC " ; date
  echo -e "\n${RED}Machine stats :$NC " ; uptime
  echo -e "\n${RED}Memory stats :$NC " ; free
  myip > /dev/null 2>&1
  echo -e "\n${RED}Local IP Address :$NC" ; echo ${IP:-"Not connected"}
  echo
}



## Files and Directories
##
#special file create
function touch {
  dir=`expr "$1" : '\(.*\/\)'`
  if [ $dir ]
    then
    mkdir -p $dir
  fi
/usr/bin/touch $1
}



#home folder
function h
{
  echo $HOME
}



#find a file with the string in the name
function ff() { find . -name '*'$1'*' ; }


#find a file with the string in the name and exec $2 on it
function fe() { find . -name '*'$1'*' -exec $2 {} \; ; }


#find a file ending in $2 and search for string $1 in it
function fstr() # find a string in a set of files
{
  if [ $# -ne 2 ]; then
    echo "Usage: fstr \"pattern\" [files] "
    return;
  fi
  SMSO=$(tput smso)
  RMSO=$(tput rmso)
  find . -type f -name "*${2}" -print | xargs grep -sin "$1" | \
  sed "s/$1/$SMSO$1$RMSO/gI"
}


#remove spaces from filename
function nospace()
{
    mv "$1" "`echo $1 | tr ' ' '_'`"
}


#filenames to lowercase
function lowercase()
{
  for file ; do
    filename=${file##*/}
    case "$filename" in
      */*) dirname==${file%/*} ;;
      *) dirname=.;;
    esac
    nf=$(echo $filename | tr A-Z a-z)
    newname="${dirname}/${nf}"
    if [ "$nf" != "$filename" ]; then
      mv "$file" "$newname"
    else
      echo "lowercase: $file not changed."
    fi
  done
}


## Get the commands and aliases
##
#list all the aliases
function list_aliases
{
    ALIASES=`alias | cut -d '=' -f 1`
    echo "$ALIASES" | sort -u
}


#list all the commands
function list_commands
{
    COMMANDS=`echo -n $PATH | xargs -d : -I {} find {} -maxdepth 1 \
        -executable -type f -printf '%P\n'`
    echo "$COMMANDS" | sort -u
}


#find an alias
function lag
{
  for a in $(list_aliases | grep $1); do which $a; done
}


#find a command
function lcg
{
  for c in $(list_commands | grep $1); do which $c; done
}

## Git & Deployment
##
#ship the current branch
function ship()
{
  CURRENT=`git branch | grep '\*' | awk '{print $2}'`
  git checkout master
  git merge ${CURRENT}
  git push github master
  git push wsl master
  git checkout ${CURRENT}
}

## Application Specific
##
#use hub browser to get at the github and shut chrome up
function gbrow()
{
  git browse $@ &>/dev/null;
}

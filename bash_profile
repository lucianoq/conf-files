# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
   . ~/.bashrc
fi

# User specific environment and startup programs

export GOPATH=$HOME/go
export PATH=$PATH:$HOME/bin:$GOPATH/bin

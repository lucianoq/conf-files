# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
   . /etc/bashrc
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f /home/lucianoq/opt/google-cloud-sdk/path.bash.inc ]; then
   source '/home/lucianoq/opt/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /home/lucianoq/opt/google-cloud-sdk/completion.bash.inc ]; then
   source '/home/lucianoq/opt/google-cloud-sdk/completion.bash.inc'
fi


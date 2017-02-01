alias k    "kubectl"
alias kd   "kubectl describe"
alias kg   "kubectl get"
alias kgp  "kubectl get pods"
alias kc   "kubectl create"
alias kdel "kubectl delete"
alias ke   "kubectl exec -it"
alias kdes "kubectl describe"
alias kl   "kubectl logs"

alias vi    'vim'
alias ccat  'pygmentize -f terminal '
function cless
    pygmentize -f terminal $argv | less -R
end

alias ctrlc 'xclip -selection clipboard -i'
alias ctrlv 'xclip -selection clipboard -o'

alias gits  'git status '

alias cd.. 'cd ..'
alias ..   'cd ..'
alias ..2  "cd ../.."
alias ..3  "cd ../../.."
alias ..4  "cd ../../../.."
alias ..5  "cd ../../../../.."

alias ls   "ls --color=auto"

alias echon "echo -n"

function ff; find . -name '*'$argv'*' ; end


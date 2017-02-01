. ~/.config/fish/aliases.fish

set -x LESS_TERMCAP_mb (set_color ff0000)
set -x LESS_TERMCAP_md (set_color ff0000)
set -x LESS_TERMCAP_me (set_color ffffff)
set -x LESS_TERMCAP_se (set_color ffffff)
set -x LESS_TERMCAP_so (set_color 00ff00)
set -x LESS_TERMCAP_ue (set_color ffffff)
set -x LESS_TERMCAP_us (set_color 00ff00)

function fish_prompt
    # $status gets nuked as soon as something else is run
    set -l last_status $status

    # c0 to _WHT progress from dark to bright
    # ce is the error colour
    set -g c0 (set_color 005284)
    set -g c1 (set_color 0075cd)
    set -g c2 (set_color 009eff)
    set -g c3 (set_color 6dc7ff)
    set -g _WHT (set_color ffffff)
    set -g ce (set_color ff8a00)
    set -g _YEL (set_color ffcc00)
    # Clear the line because fish seems to emit the prompt twice. The initial
    # display, then when you press enter.
    printf "\033[K"

    # PRINT NEWLINE
    echo

    # STATUS
    if [ $last_status -eq 0 ]
    	#set_color 00ff00; printf "✔   "
    	set_color 00ff00; printf " ✔ "
    else
    	set_color ff0000; printf "✘"
    	set_color 005284; printf "="
    	set_color ff8a00; printf "$last_status "
    end

    # CURRENT TIME
#    set_color ffffff; printf "["
#    printf (date "+$c2%H$c0:$c2%M$c0:$c2%S")
#    set_color ffffff; printf "] "

    # DIRECTORY
    set_color ff8a00; printf (pwd | sed "s:$HOME:~:" | sed "s,/,$_YEL/$ce,g") # | sed "s,\(.*\)/[^m]*m,\1/$c3,")

    # GIT
    set is_git (git rev-parse --is-inside-work-tree ^/dev/null)
    if [ "$is_git" = "true" ]
    	set -g git_branch (git branch | awk '/^\*/ { print $2 }')
    	set -g git_dirty_count (git status --porcelain  | wc -l | sed "s/ //g")
    	set_color 0075cd; printf "  ☿"
    	set_color 005284; printf ":"
    	set_color 009eff; printf "$git_branch$c0:$ce$git_dirty_count "
    	#set_color ff8a00; printf "$argv[3]"
    	#set_color 005284; printf ", "
    end

    # Prompt on a new line
#    printf "\n"
    set_color ff9900; printf "  ➤  "

    printf $_WHT
end


if status --is-login
    . ~/.config/fish/env.fish
end

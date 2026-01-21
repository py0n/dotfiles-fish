function tmux --description 'tmux with auto-attaching'
    if not type -q tmux
        return 1
    end

    set -l n (count $argv)
    if test $n -gt 0
        command tmux $argv
    else if command tmux has-session 2>/dev/null
        command tmux attach
    else
        command tmux -2
    end
end

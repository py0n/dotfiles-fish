function C --description 'fzf git-commit'
    if not type -q git; or not type -q fzf
        return 1
    end
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1; or return 1

    set -l pick (command git log --full-history \
        --date=format:'%Y/%m/%d %H:%M:%S' \
        --pretty=format:'%h [%ad] %an : %s %d' \
        | fzf --ansi --cycle)

    test -n "$pick"; or return 0
    echo -n (string split -m1 ' ' -- $pick)[1]
end

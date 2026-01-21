function V --description 'fzf git-branch (remote)'
    if not type -q git; or not type -q fzf
        return 1
    end
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1; or return 1

    set -l pick (command git branch -rvv | string trim | fzf --ansi --cycle)
    test -n "$pick"; or return 0
    echo -n (string split -m1 ' ' -- $pick)[1]
end

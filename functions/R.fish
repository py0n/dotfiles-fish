function R --description 'fzf ghq list'
    if not type -q ghq
        return 1
    end
    if not type -q fzf
        return 1
    end

    set -l cmd fzf
    if set -q TMUX; and type -q --no-functions fzf-tmux
        set cmd fzf-tmux
    end

    set -l root (ghq root)
    set -l pick (ghq list | command $cmd --ansi --cycle --layout=reverse-list)

    test -n "$pick"; or return 0
    echo -n "$root/$pick"
end

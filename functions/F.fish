function F --description 'fzf git-ls-files'
    if not type -q git; or not type -q fzf
        return 1
    end
    command git rev-parse --is-inside-work-tree >/dev/null 2>&1; or return 1

    command git ls-files | fzf --ansi --cycle
end

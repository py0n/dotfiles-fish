function ssh --description 'ssh (no args: pick Host from ~/.ssh/config via fzf)'
    # 引数があればそのまま ssh
    if test (count $argv) -gt 0
        command ssh $argv
        return $status
    end

    # ~/.ssh/config が無ければ通常の ssh を起動（usage を出したい人向け）
    set -l cfg ~/.ssh/config
    if not test -r $cfg
        command ssh
        return $status
    end

    # Host 行から候補を抽出（ワイルドカードを除外）
    # 例: Host foo bar baz → foo / bar / baz を列挙
    set -l hosts (awk '
        tolower($1) == "host" {
            for (i=2; i<=NF; i++) {
                if ($i !~ /[*?]/) print $i
            }
        }' $cfg | sort -u)

    if test (count $hosts) -eq 0
        return 1
    end

    set -l picker fzf
    if set -q TMUX; and type -q --no-functions fzf-tmux
        set picker fzf-tmux
    end

    set -l target (printf "%s\n" $hosts | command $picker --ansi --cycle --layout=reverse-list)

    # Esc などで空なら何もしない
    if test -z "$target"
        return 0
    end

    command ssh $target
end

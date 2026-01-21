function fzf_key_bindings --description 'Load fzf key bindings if installed'
    # fzf の公式インストール先（よくある）
    set -l candidates \
        "$HOME/.fzf/shell/key-bindings.fish" \
        "/usr/share/fzf/key-bindings.fish" \
        "/usr/local/share/fzf/key-bindings.fish"

    for f in $candidates
        if test -r $f
            source $f
            return 0
        end
    end

    # 見つからない場合は何もしない（起動時エラー回避）
    return 0
end

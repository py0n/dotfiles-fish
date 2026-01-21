# anyenv init の出力を fish 用スクリプトとしてキャッシュする
#
# - `anyenv init` は起動時に実行すると非常に重いため、
#   実行結果をキャッシュして source だけで済ませるための関数
# - キャッシュは fish でそのまま source 可能な `.fish` ファイルとして保存する
# - anyenv の設定変更・アップデート後に「手動で」実行する想定
#
# 保存先:
#   $XDG_CACHE_HOME/fish/anyenv_init.fish
#   （XDG_CACHE_HOME 未定義時は ~/.cache/fish/anyenv_init.fish）
#
# 実行例:
#   anyenv_refresh_cache
#     -> 次回以降の shell 起動では source だけで anyenv が初期化される
#
# 注意:
#   この関数は起動時に呼ばないこと。
#   起動時に毎回 `anyenv init` を実行すると起動が大幅に遅くなる。
function anyenv_refresh_cache --description 'Refresh cached anyenv init script'
    # キャッシュ保存先（XDG_CACHE_HOME 優先）
    set -l cachedir (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo "$HOME/.cache")
    set -l cache "$cachedir/fish/anyenv_init.fish"
    command mkdir -p (path dirname $cache)

    # anyenv init の出力をそのまま保存
    $HOME/.anyenv/bin/anyenv init - > $cache
end

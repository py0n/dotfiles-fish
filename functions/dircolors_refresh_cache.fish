# dircolors の結果を fish 用スクリプトとしてキャッシュする
#
# - dircolors は毎回実行すると遅いため、結果を $XDG_CACHE_HOME に保存する
# - 保存形式は fish で source できる `.fish` ファイル
# - ~/.dir_colors を変更したときだけ手動で呼び出す想定
#
# 処理内容:
#   1. `dircolors -c ~/.dir_colors` を実行（csh 形式: setenv VAR value）
#   2. 出力を fish の `set -gx VAR value` 形式に変換
#   3. $XDG_CACHE_HOME/fish/dircolors.fish に保存
#
# 実行例:
#   dircolors_refresh_cache
#     -> 次回以降の shell 起動では source だけで色設定が反映される
# NOTE:
#   この関数は起動時に呼ばないこと。
#   起動時はキャッシュされた dircolors.fish を source するだけにする。
function dircolors_refresh_cache --description 'Refresh cached dircolors (fish)'
    # dircolors または ~/.dir_colors が無ければ何もしない
    if not type -q dircolors; or not test -f $HOME/.dir_colors
        return 0
    end

    # キャッシュ保存先（XDG_CACHE_HOME 優先）
    set -l cachedir (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo "$HOME/.cache")
    set -l cache "$cachedir/fish/dircolors.fish"
    command mkdir -p (path dirname $cache)

    # dircolors -c は csh 形式 (setenv VAR value) を出力するため、
    # fish で source 可能な `set -gx VAR value` に変換して保存する
    dircolors -c $HOME/.dir_colors \
        | string replace -r '^setenv ([A-Z_]+) ' 'set -gx $1 ' \
        > $cache
end

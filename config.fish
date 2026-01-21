# ============================================================
# fish config.fish
# fish 4.3.3 向け
#
# ・ログイン / 非ログイン問わず読み込まれる
# ============================================================


# ------------------------------------------------------------
# XDG Base Directory 対応
# ------------------------------------------------------------
# fish が内部で参照する config / data ディレクトリを
# XDG_*_HOME に合わせる
set -g configdir ~/.config
set -q XDG_CONFIG_HOME; and set configdir $XDG_CONFIG_HOME

set -g userdatadir ~/.local/share
set -q XDG_DATA_HOME; and set userdatadir $XDG_DATA_HOME


# ------------------------------------------------------------
# WSL (Linux on Windows) 判定
# ------------------------------------------------------------
# WSL 環境では umask が変なことがあるため明示指定
if string match -q -r 'Linux' (uname -a); and string match -q -r 'Microsoft' (uname -a)
    umask 0022
end


# interactive 以外はここで終了（スクリプト実行等を軽く）
status --is-interactive; or exit

# ============================================================
# interactive shell 用の環境設定
# ============================================================

# --------------------------------------------------------
# fish 4.3+ frozen 設定の吸収
# --------------------------------------------------------
# fish 4.3.0 以降は fish_color_* や fish_key_bindings が
# universal ではなく global 変数になる。
#
# upgrade 時に自動生成される
#   conf.d/fish_frozen_theme.fish
#   conf.d/fish_frozen_key_bindings.fish
# の中身を、ここに集約するための設定。
#
# ※ これを入れたら frozen_* ファイルは削除してOK

# キーバインド（デフォルトを使う場合はコメントのままで良い）
# set --global fish_key_bindings fish_default_key_bindings

# ---- テーマ / 色設定 ----
set --global fish_color_cancel -r
set --global fish_color_cwd_root red
set --global fish_color_history_current --bold
set --global fish_color_host_remote yellow
set --global fish_color_selection white --bold --background=brblack
set --global fish_color_status red
set --global fish_color_user brgreen
set --global fish_color_valid_path --underline

set --global fish_pager_color_completion
set --global fish_pager_color_description B3A06D yellow
set --global fish_pager_color_prefix white --bold --underline
set --global fish_pager_color_progress brwhite --background=cyan
set --global fish_pager_color_selected_background -r
# -------------------------

# --------------------------------------------------------
# EDITOR 設定
# --------------------------------------------------------
# vim / nvim があればそちらを優先
type -q vim;  and set -gx EDITOR vim
type -q nvim; and set -gx EDITOR nvim


# --------------------------------------------------------
# fzf 設定
# --------------------------------------------------------
# ANSI カラーを有効化
set --global --export FZF_DEFAULT_OPTS '--ansi'


# --------------------------------------------------------
# Go 環境変数の掃除
# --------------------------------------------------------
# shell 起動時に GOARCH / GOOS が残っていると
# ビルドが壊れることがあるため常に削除
set --erase GOARCH
set --erase GOOS


# --------------------------------------------------------
# ロケール
# --------------------------------------------------------
set --global --export LANG ja_JP.UTF-8


# --------------------------------------------------------
# ddc-nextword 用設定
# --------------------------------------------------------
# コマンドが存在する場合のみ環境変数を設定
type -q nextword; and set -gx NEXTWORD_DATA_PATH $HOME/.local/share/nextword-data-large


# ============================================================
# ssh-agent 管理
# ============================================================
# 既に SSH_AUTH_SOCK が有効なら何もしない
if set -q SSH_AUTH_SOCK; and test -S "$SSH_AUTH_SOCK"
    # OK
else
    # sock が無い/死んでる時だけ起動・修復
    reset_ssh_auth_sock
end


# ============================================================
# resources/*.fish のロード
# ============================================================
set -l resdir $configdir/fish/resources

# 必要なものだけ読み込む
if test -r "$resdir/informative_vcs.fish"
    source "$resdir/informative_vcs.fish"
end


# ============================================================
# $HOME 以下への rc ファイル展開（初回のみ）
# ============================================================
# すでに存在するものは触らない（起動を軽くする）
for f in $configdir/fish/extra/rc/*
    set -l name (path basename $f)
    set -l dst  "$HOME/.$name"
    if not test -e $dst
        command ln -s $f $dst
    end
end


# ============================================================
# deno
# ============================================================
set -gx DENO_INSTALL $HOME/.deno


# ============================================================
# dircolors（キャッシュ）
# ============================================================
set -l cachedir (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo "$HOME/.cache")
set -l cache "$cachedir/fish/dircolors.fish"

if test -r $cache
    source $cache
else
    dircolors_refresh_cache
    test -r $cache; and source $cache
end


# ============================================================
# anyenv（init をキャッシュ）
# ============================================================
set -l cachedir (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo "$HOME/.cache")
set -l cache "$cachedir/fish/anyenv_init.fish"

if test -r $cache
    source $cache
else
    anyenv_refresh_cache
    source $cache
end


# ============================================================
# PATH の重複削除（外部コマンドを使わない）
# ============================================================
set -l new_path
for p in $PATH
    if not contains -- $p $new_path
        set -a new_path $p
    end
end
set -gx PATH $new_path


# vim: foldmethod=marker

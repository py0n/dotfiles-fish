# ============================================================
# ~/.config/fish/config.fish  (fish 4.3.3)
#
# 方針:
# - config.fish はログイン/非ログイン問わず読み込まれる
# - 対話シェル専用の設定は `status --is-interactive` で切り分ける
# - 起動を重くする外部コマンド（anyenv init / dircolors / ps 等）は
#   可能ならキャッシュ化・条件付き実行にする
# ============================================================


# ------------------------------------------------------------
# XDG Base Directory 対応
# ------------------------------------------------------------
# fish が参照する config / data ディレクトリを XDG_*_HOME に合わせる
# （XDG_*_HOME が未設定なら従来の ~/.config / ~/.local/share を使う）
set -g configdir ~/.config
set -q XDG_CONFIG_HOME; and set configdir $XDG_CONFIG_HOME

set -g userdatadir ~/.local/share
set -q XDG_DATA_HOME; and set userdatadir $XDG_DATA_HOME


# ------------------------------------------------------------
# WSL (Linux on Windows) 判定
# ------------------------------------------------------------
# WSL 環境では umask が期待と違うことがあるため明示指定
if string match -q -r 'Linux' (uname -a); and string match -q -r 'Microsoft' (uname -a)
    umask 0022
end


# interactive 以外はここで終了（スクリプト実行等を軽く）
status --is-interactive; or exit

# ============================================================
# interactive shell 用の環境設定
# ============================================================

# キャッシュ保存先（XDG_CACHE_HOME 優先）
# - dircolors / anyenv の初期化結果を保存して、普段は source だけで済ませる
set -l cachedir (set -q XDG_CACHE_HOME; and echo $XDG_CACHE_HOME; or echo "$HOME/.cache")


# --------------------------------------------------------
# fish 4.3+ 移行メモ（universal → global）
# --------------------------------------------------------
# fish 4.3 以降では fish_color_* / fish_pager_color_* / fish_key_bindings が
# universal ではなく global 変数として扱われる。
# upgrade 時に conf.d/fish_frozen_*.fish が生成されることがあるが、
# 現在はそれらを使わず（削除済みの想定）、必要ならここや conf.d 側で明示設定する。

# キーバインド（デフォルトを使う場合はコメントのままで良い）
# set --global fish_key_bindings fish_default_key_bindings


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
# shell 起動時に GOARCH / GOOS が残っているとビルド事故の原因になるため削除
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
# ssh-agent 管理（対話シェル）
# - SSH_AUTH_SOCK が有効なら何もしない（起動を軽くする）
# ============================================================
if set -q SSH_AUTH_SOCK; and test -S "$SSH_AUTH_SOCK"
    # OK
else
    # sock が無い/死んでる時だけ起動・修復
    reset_ssh_auth_sock
end


# ============================================================
# resources の読み込み（対話シェル）
# - resources は任意拡張（prompt など）を分離して置く場所
# - glob で全部 source すると増えるほど遅くなるので、必要なものだけ読む
# ============================================================
set -l resdir $configdir/fish/resources

# 必要なものだけ読み込む
if test -r "$resdir/informative_vcs.fish"
    source "$resdir/informative_vcs.fish"
end


# ============================================================
# extra/rc の展開（初回のみ）
# - ~/.config/fish/extra/rc/* を ~/.<name> に symlink する
# - 起動のたびに ln -sfn で上書きすると重い＆副作用が大きいので、
#   ここでは「無ければ作る」だけにしている
# - 内容を更新したいときは update_rc_links（手動）を使う
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
# - インストール先を環境変数で固定（PATH 追加は別途）
# ============================================================
set -gx DENO_INSTALL $HOME/.deno


# ============================================================
# dircolors（キャッシュ）
# - dircolors の実行は遅いので、結果をキャッシュして普段は source だけにする
# - ~/.dir_colors を編集したら dircolors_refresh_cache を手動で実行して更新する
# ============================================================
set -l cache "$cachedir/fish/dircolors.fish"

if test -r $cache
    source $cache
else
    dircolors_refresh_cache
    test -r $cache; and source $cache
end


# ============================================================
# anyenv（init をキャッシュ）
# - anyenv init は起動時に重いので、結果をキャッシュして普段は source だけにする
# - anyenv の更新/設定変更後は anyenv_refresh_cache を手動で実行して更新する
# ============================================================
set -l cache "$cachedir/fish/anyenv_init.fish"

if test -r $cache
    source $cache
else
    anyenv_refresh_cache
    source $cache
end


# ============================================================
# PATH の重複削除（外部コマンドを使わない）
# - anyenv 等が PATH を重ねて追加する環境向けの保険
# - 可能なら「重複の原因を直してこの処理自体を消す」のが最速
# ============================================================
set -l new_path
for p in $PATH
    if not contains -- $p $new_path
        set -a new_path $p
    end
end
set -gx PATH $new_path


# vim: foldmethod=marker

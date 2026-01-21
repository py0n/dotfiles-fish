# ============================================================
# fish config.fish
# fish 4.3.3 向け
#
# ・ログイン / 非ログイン問わず読み込まれる
# ・基本的に interactive shell の設定は
#   `if status --is-interactive` で囲う
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


# ============================================================
# interactive shell 用の環境設定
# ============================================================
if status --is-interactive

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
end


# ============================================================
# ssh-agent 管理
# ============================================================

# ------------------------------------------------------------
# SSH_AUTH_SOCK をユーザ固定の symlink に寄せる
# ------------------------------------------------------------
function __set_ssh_auth_sock
    set --local symlink $HOME/.ssh-agent-$USER

    # 既存の SSH_AUTH_SOCK が symlink でなければ張り替える
    if test -S "$SSH_AUTH_SOCK"; and not test -L "$SSH_AUTH_SOCK"
        command ln -sfn "$SSH_AUTH_SOCK" "$symlink"
        set --global --export SSH_AUTH_SOCK "$symlink"
    end
end


# ------------------------------------------------------------
# ssh-agent を安全に再起動する
# ------------------------------------------------------------
function __restart_ssh_agent

    # ssh-agent が複数起動していたら全 kill
    if type -q pgrep
        set -l agents (pgrep -x ssh-agent)
        if test (count $agents) -gt 1
            command killall ssh-agent
        end
    else
        if test (ps acux | grep -c '[s]sh-agent') -gt 1
            command killall ssh-agent
        end
    end

    # 環境変数が壊れていたら掃除
    set --query SSH_AUTH_SOCK; or command killall ssh-agent
    set --query SSH_AGENT_PID;  or command killall ssh-agent

    # ssh-agent が動いていなければ起動
    if type -q pgrep
        pgrep -x ssh-agent >/dev/null; or eval (
            command ssh-agent -c |
            string replace --regex '\Asetenv' 'set --global --export'
        )
    else
        ps acux | grep '[s]sh-agent' >/dev/null; or eval (
            command ssh-agent -c |
            string replace --regex '\Asetenv' 'set --global --export'
        )
    end

    # PID を再設定
    if type -q pgrep
        set --global --export SSH_AGENT_PID (pgrep -nx ssh-agent)
    else
        set --global --export SSH_AGENT_PID (
            ps acux | grep '[s]sh-agent' | awk '{split($0,e," *");print e[2]}'
        )
    end
end


# ============================================================
# ssh-agent（必要時のみ）
# ============================================================
function reset_ssh_auth_sock
    # SSH 接続中でなければ agent を再起動
    set --query SSH_CONNECTION
    if test $status -gt 0
        __restart_ssh_agent
    end

    __set_ssh_auth_sock
end

if status --is-interactive
    # 既に SSH_AUTH_SOCK が有効なら何もしない
    if set -q SSH_AUTH_SOCK; and test -S "$SSH_AUTH_SOCK"
        # OK
    else
        # sock が無い/死んでる時だけ起動・修復
        reset_ssh_auth_sock
    end
end


# ============================================================
# resources/*.fish のロード
# ============================================================
if status --is-interactive
    # 任意の拡張設定を resources/ 以下に分離
    for f in {$configdir}/fish/resources/*.fish
        source $f
    end

    # resource を一時的に無効化
    function resource_disable -a name
        set -l f {$configdir}/fish/resources/{$name}.fish
        if test -f $f
            command mv $f {$f}_
        end
    end

    # 無効化した resource を再有効化
    function resource_enable -a name
        set -l f {$configdir}/fish/resources/{$name}.fish_
        if test -f $f
            command mv $f {$configdir}/fish/resources/{$name}.fish
        end
    end
end


# ============================================================
# $HOME 以下への rc ファイル展開
# ============================================================
if status --is-interactive
    # ~/.config/fish/extra/rc/* を ~/.<name> に symlink
    for f in {$configdir}/fish/extra/rc/*
        ln -sfn $f $HOME/.(string split '/' $f)[-1]
    end
end


# ============================================================
# deno
# ============================================================
if status --is-interactive
    set -gx DENO_INSTALL $HOME/.deno
end


# ============================================================
# dircolors
# ============================================================
if status --is-interactive
    if test -f $HOME/.dir_colors; and type -q dircolors
        eval (dircolors -c $HOME/.dir_colors)
    end
end


# ============================================================
# anyenv
# ============================================================
if status --is-interactive; and test -x $HOME/.anyenv/bin/anyenv
    source (anyenv init - | psub)
end


# ============================================================
# PATH の重複削除（外部コマンドを使わない）
# ============================================================
if status --is-interactive
    set -l new_path
    for p in $PATH
        if not contains -- $p $new_path
            set -a new_path $p
        end
    end
    set -gx PATH $new_path
end


# vim: foldmethod=marker

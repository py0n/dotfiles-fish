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

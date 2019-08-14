# from share/fish/config.fish
set -g configdir ~/.config

set -q XDG_CONFIG_HOME; and set configdir $XDG_CONFIG_HOME

set -g userdatadir ~/.local/share

set -q XDG_DATA_HOME; and set userdatadir $XDG_DATA_HOME

# Bash on Ubuntu on Windows
if string match -q -r 'Linux' (uname -a); and string match -q -r 'Microsoft' (uname -a)
    umask 0022
end

# environments (at interactive shell) {{{
if status --is-interactive
    # EDITOR
    type --quiet vim;  and set -gx EDITOR vim
    type --quiet nvim; and set -gx EDITOR nvim
    # FZF
    set --global --export FZF_DEFAULT_OPTS '--ansi'
    # GOARCH, GOOSが設定されていたら削除
    set --erase GOARCH
    set --erase GOOS
    # LANG
    set --global --export LANG ja_JP.UTF-8
end
# }}}

# ssh-agent (at interactive shell) {{{
function __set_ssh_auth_sock # {{{

    set --local symlink $HOME/.ssh-agent-$USER

    if test -S $SSH_AUTH_SOCK; and not test -L $SSH_AUTH_SOCK
        command ln -sfn $SSH_AUTH_SOCK $symlink
        set --global --export SSH_AUTH_SOCK $symlink
    end
end # }}}

function __restart_ssh_agent # {{{

    # ssh-agentが複数動いている場合
    if test (ps acux | grep 'ssh-agent' | wc -l) -gt 1
        command killall ssh-agent
    end

    # SSH_AUTH_SOCK
    set --query SSH_AUTH_SOCK
    if test $status -gt 0
        command killall ssh-agent
    end

    # SSH_AGENT_PID
    set --query SSH_AGENT_PID
    if test $status -gt 0
        command killall ssh-agent
    end

    # ssh-agentが動いていない場合
    ps acux | grep 'ssh-agent' > /dev/null
    if test $status -gt 0
        eval (command ssh-agent -c | string replace --regex '\Asetenv' 'set --global --export')
    end

    set --global --export SSH_AGENT_PID (ps acux | grep 'ssh-agent' | awk '{split($0,e," *");print e[2]}')
end # }}}

function reset_ssh_auth_sock # {{{

    set --query SSH_CONNECTION
    if test $status -gt 0
        __restart_ssh_agent
    end

    __set_ssh_auth_sock
end # }}}

if status --is-interactive
    reset_ssh_auth_sock
end
# }}}

# resources (at interactive shell) {{{
if status --is-interactive
    for f in {$configdir}/fish/resources/*.fish
        source $f
    end

    function resource_disable -a name
        set -l f {$configdir}/fish/resources/{$name}.fish
        if test -f $f
            command mv {$configdir}/fish/resources/{$name}.fish {$configdir}/fish/resources/{$name}.fish_
        end
    end

    function resource_enable -a name
        set -l f {$configdir}/fish/resources/{$name}.fish_
        if test -f $f
            command mv {$configdir}/fish/resources/{$name}.fish_ {$configdir}/fish/resources/{$name}.fish
        end
    end
end
# }}}

# $HOME/*rc {{{
if status --is-interactive
    for f in {$configdir}/fish/extra/*
        ln -sfn $f $HOME/.(string split '/' $f)[-1]
    end
end
# }}}

# dir_colors {{{
if status --is-interactive
    if test -f $HOME/.dir_colors; and type -q -t dircolors
        eval (dircolors -c $HOME/.dir_colors)
    end
end
# }}}

# go {{{
if status --is-interactive
    test -d $HOME/go-packages;  or mkdir -p $HOME/go-packages/{bin,pkg,src}
    test -d $HOME/go-workspace; or mkdir -p $HOME/go-workspace/{bin,pkg,src}
    set -gx GOPATH $HOME/go-packages:$HOME/go-workspace
end
# }}}

# *env (at interactive shell) {{{
# https://github.com/riywo/anyenv#install
# anyenv {{{
if status --is-interactive; and test -x $HOME/.anyenv/bin/anyenv
    # fish_user_pathsに追加していればPATHへの追加は不要
    # set -x PATH $HOME/.anyenv/bin $PATH
    source (anyenv init -|psub)
end
# }}}
# }}}

# Remove duplicate elements from PATH (at interactive shell) {{{
if status --is-interactive
    set -gx PATH (for i in $PATH; echo $i; end | awk '!a[$0]++{print}')
end
# }}}

# vim: foldmethod=marker

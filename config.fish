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
    type -q vim;  and set -gx EDITOR vim
    type -q nvim; and set -gx EDITOR nvim
    # FZF
    set -gx FZF_DEFAULT_OPTS '--ansi'
    # GOARCH, GOOSが設定されていたら削除
    set -e GOARCH
    set -e GOOS
    # LANG
    set -gx LANG ja_JP.UTF-8
end
# }}}

# ssh-agent (at interactive shell) {{{
if status --is-interactive
    set -l SSH_AUTH_SOCK_SYMLINK $HOME/.ssh-agent-$USER
    if set -q SSH_AUTH_SOCK; and test -S $SSH_AUTH_SOCK; and test ! -L $SSH_AUTH_SOCK
        ln -sfn $SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
        set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    else if test -S $SSH_AUTH_SOCK_SYMLINK
        set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    end
    command ssh-add -L >/dev/null ^&1
    if test $status -ne '0'
        eval (ssh-agent -c | string replace --regex '\Asetenv' 'set -gx')
        ln -sfn $SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
        set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    end
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

# ndenv {{{
# https://github.com/riywo/ndenv#install
if status --is-interactive; and test -x $HOME/.ndenv/bin/ndenv
    set -gx PATH $HOME/.ndenv/shims $PATH
    # 'ndenv init -' がfishに対応していないので茲に内容を記載
    # https://github.com/riywo/ndenv/pull/14
    # https://github.com/riywo/ndenv/pull/15
    # など、PRが出てゐるが取り込まれてゐない。
    command ndenv rehash 2> /dev/null
    function ndenv
        set command $argv[1]
        set -e argv[1]
        switch "$command"
        case rehash shell
            source (ndenv "sh-$command" $argv|psub)
        case '*'
            command ndenv "$command" $argv
        end
    end
end
# }}}
# }}}

# Remove duplicate elements from PATH (at interactive shell) {{{
if status --is-interactive
    set -gx PATH (for i in $PATH; echo $i; end | awk '!a[$0]++{print}')
end
# }}}

# vim: foldmethod=marker

# from share/fish/config.fish
set -g configdir ~/.config

if set -q XDG_CONFIG_HOME
    set configdir $XDG_CONFIG_HOME
end

set -g userdatadir ~/.local/share

if set -q XDG_DATA_HOME
    set userdatadir $XDG_DATA_HOME
end

# Bash on Ubuntu on Windows
if string match -q -r 'Linux' (uname -a); and string match -q -r 'Microsoft' (uname -a)
    umask 0022
end

# interactive shell {{{
if status --is-interactive
    if type -q nvim
        set -gx EDITOR nvim
    else if type -q vim
        set -gx EDITOR vim
    end
    set -gx FZF_DEFAULT_OPTS '--ansi'
    set -gx LANG ja_JP.UTF-8

    # ssh-agent {{{
    set -l SSH_AUTH_SOCK_SYMLINK $HOME/.ssh-agent-$USER
    if set -q SSH_AUTH_SOCK; and test -S $SSH_AUTH_SOCK; and test ! -L $SSH_AUTH_SOCK
        ln -sfn $SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
        set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    else if test -S $SSH_AUTH_SOCK_SYMLINK
        set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    end

    command ssh-add -L >/dev/null ^&1
    if test $status -ne '0'
        eval (ssh-agent -c | grep '^setenv')
        ln -sfn $SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
        set -gx SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    end
    # }}}

    # resources
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

    # Go {{{
    if test -d $HOME/.goenv
        set -gx GOENV_ROOT $HOME/.goenv
        set -gx GOPATH $HOME/go
        status --is-interactive; and source (goenv init -|psub)
    end
    # }}}

    # Remove duplicate elements from PATH {{{
    set -gx PATH (for i in $PATH; echo $i; end | awk '!a[$0]++{print}')
    # }}}
end
# }}}

# vim: foldmethod=marker

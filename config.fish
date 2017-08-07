# from share/fish/config.fish
set -l configdir ~/.config

if set -q XDG_CONFIG_HOME
    set configdir $XDG_CONFIG_HOME
end

set -l userdatadir ~/.local/share

if set -q XDG_DATA_HOME
    set userdatadir $XDG_DATA_HOME
end

# login shell {{{
if status --is-login
    set -x LANG ja_JP.UTF-8

    set -x FZF_DEFAULT_OPTS '--ansi'

    set SSH_AUTH_SOCK_SYMLINK $HOME/.ssh-agent-$USER
    if test -S "$SSH_AUTH_SOCK"; and test ! -L "$SSH_AUTH_SOCK"
        ln -sfn $SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
        set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    else if test -S $SSH_AUTH_SOCK_SYMLINK
        set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    end

    # solarized
    # https://github.com/ithinkihaveacat/dotfiles/blob/master/fish/solarized.fish
    source {$configdir}/fish/resources/solarized.fish

    # https://github.com/fish-shell/fish-shell/blob/master/share/tools/web_config/sample_prompts/informative_vcs.fish
    source {$configdir}/fish/resources/informative_vcs.fish

    # Go {{{
    if test -d $HOME/.goenv
        set -x GOENV_ROOT $HOME/.goenv
        set -x GOPATH $HOME/go
        status --is-interactive; and source (goenv init -|psub)
    end
    # }}}

    # PATHの重複を除去 {{{
    # http://qiita.com/arcizan/items/9cf19cd982fa65f87546
    # http://qiita.com/itkr/items/1b868d75e54802e8d11a
    set -x PATH ( echo $PATH | tr ' ' '\n' | awk '!a[$0]++' )
    # }}}

end
# }}}

# vim: foldmethod=marker

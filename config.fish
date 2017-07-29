# from share/fish/config.fish
set -l configdir ~/.config

if set -q XDG_CONFIG_HOME
    set configdir $XDG_CONFIG_HOME
end

set -l userdatadir ~/.local/share

if set -q XDG_DATA_HOME
    set userdatadir $XDG_DATA_HOME
end

set -x LANG ja_JP.UTF-8

set SSH_AUTH_SOCK_SYMLINK $HOME/.ssh-agent-$USER
if test -S $SSH_AUTH_SOCK -a ! -L $SSH_AUTH_SOCK
    ln -sfn $SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
    set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
else if test -S $SSH_AUTH_SOCK_SYMLINK
    set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK_SYMLINK
end

# solarized
# https://github.com/ithinkihaveacat/dotfiles/blob/master/fish/solarized.fish
source {$configdir}/fish/resources/solarized.fish

source {$configdir}/fish/resources/informative_vcs.fish

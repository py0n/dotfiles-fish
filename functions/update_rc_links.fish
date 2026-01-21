# NOTE:
#   - 安全確認したい場合は update_rc_links_dry_run を使う
#   - force が必要なときだけこの関数を使う
function update_rc_links --description 'Symlink extra/rc files into $HOME (force)'
    for f in $configdir/fish/extra/rc/*
        set -l name (path basename $f)
        set -l dst  "$HOME/.$name"
        command ln -sfn $f $dst
    end
end

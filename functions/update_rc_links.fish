# extra/rc 配下の設定ファイルを $HOME/.<name> に強制 symlink する
#
# - 起動時には呼ばない（毎回 ln -sfn すると遅く・副作用が大きい）
# - extra/rc の中身を更新・追加したときに「手動で」実行する想定
# - 既存の symlink / ファイルを上書きするため注意
#
# 例:
#   update_rc_links
#     -> ~/.ackrc, ~/.tmux.conf などが extra/rc の内容に同期される
function update_rc_links --description 'Force-update symlinks from extra/rc into $HOME'
    for f in $configdir/fish/extra/rc/*
        set -l name (path basename $f)
        set -l dst  "$HOME/.$name"
        command ln -sfn $f $dst
    end
end

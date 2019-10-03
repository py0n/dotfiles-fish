# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.lLHkt9/ssh.fish @ line 2
function ssh --description 'ssh with fzf & ssh-config'
	if count $argv >/dev/null
		command ssh $argv
	else
        ssh (awk '/^Host[[:space:]]+[A-Za-z0-9_\.\-]+$/ { print $2 }' $HOME/.ssh/config | fzf --ansi --cycle --layout=reverse-list)
	end
end

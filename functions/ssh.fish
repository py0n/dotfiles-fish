# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.bkvO2G/ssh.fish @ line 2
function ssh --description 'ssh with fzf & ssh-config'
	if count $argv >/dev/null
		command ssh $argv
	else if type --quiet --no-function fzf-tmux
		command ssh (awk '/^Host[[:space:]]+[A-Za-z0-9_\.\-]+$/ { print $2 }' $HOME/.ssh/config | command fzf-tmux --ansi --cycle --layout=reverse-list)
	else
		command ssh (awk '/^Host[[:space:]]+[A-Za-z0-9_\.\-]+$/ { print $2 }' $HOME/.ssh/config | command fzf --ansi --cycle --layout=reverse-list)
	end
end

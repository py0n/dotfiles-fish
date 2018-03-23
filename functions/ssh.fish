# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.VfbF7l/slogin.fish @ line 2
function slogin --description 'slogin with fzf & ssh-config'
	if count $argv >/dev/null
		command slogin $argv
	else
        slogin (awk '/^Host[[:space:]]+[A-Za-z0-9_\.\-]+$/ { print $2 }' $HOME/.ssh/config | fzf)
	end
end

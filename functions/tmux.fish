# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.nAm4cO/tmux.fish @ line 2
function tmux --description 'tmux with auto-attaching'
	if not type -f -q tmux
		return 1
	end

	set -l n (count $argv)
	if test $n -gt 0
		command tmux $argv
	else if command tmux has-session
		command tmux attach
	else
		command tmux -2
	end
end

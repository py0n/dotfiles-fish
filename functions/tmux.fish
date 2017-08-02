# Defined in /tmp/fish.gPio6a/tmux.fish @ line 2
function tmux --description 'tmux with auto-attaching'
	if type -p tmux
		set -l n (count $argv)
		if test $n -gt 0
			command tmux $argv
		else if command tmux has-session
			command tmux attach
		else
			command tmux -2
		end
	end
end

# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.1Eq1Gu/fzf.fish @ line 2
function fzf --description 'fzf or fzf-tmux'
	# tmux exists ?
	if not type -f -p -q tmux
		return 1
	end

	# inside tmux ?
	if test -n "$TMUX"
		if type -f -p -q fzf-tmux
			command fzf-tmux $args
		else if type -f -p -q fzf
			command fzf $args
		else
			return 1
		end
	else if type -f -p -q fzf
		command fzf $args
	else
		return 1
	end
end

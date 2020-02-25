# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.ZUeWdU/G.fish @ line 2
function G --description 'narrow down git-grep'
	if not count $argv >/dev/null
		return 1
	end

	if set --query TMUX; and type --quiet --no-functions fzf-tmux
		set cmd_fzf fzf-tmux
	else
		set cmd_fzf fzf
	end
	set -l array (command git grep --perl-regexp -i -n $argv | command $cmd_fzf --ansi --cycle --layout=reverse-list | string split -m2 ':')

	if count $array >/dev/null
		command nvim "+$array[2]" "$array[1]"
	end
end

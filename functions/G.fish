# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.whxQ0e/G.fish @ line 2
function G --description 'narrow down git-grep'
	if not count $argv >/dev/null
		return 1
	end

    if test --quiet --no-function fzf-tmux
		set -l array (command git grep --perl-regexp -i -n $argv | command fzf-tmux --ansi --cycle --layout=reverse-list | string split -m2 ':')
	else
		set -l array (command git grep --perl-regexp -i -n $argv | command fzf --ansi --cycle --layout=reverse-list | string split -m2 ':')
	end

	if count $array >/dev/null
		command nvim "+$array[2]" "$array[1]"
	end
end

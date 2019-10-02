# Defined in /tmp/fish.xSgXQ0/G.fish @ line 2
function G --description 'narrow down git-grep'
	if not count $argv >/dev/null
		return 1
	end

	set -l array (command git grep -E -i -n $argv | fzf --ansi --cycle --layout=reverse-list | string split -m2 ':')

	if count $array >/dev/null
		command nvim "+$array[2]" "$array[1]"
	end
end

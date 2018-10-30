# Defined in /tmp/fish.WsYMwi/G.fish @ line 2
function G --description 'narrow down git-grep'
	if not count $argv >/dev/null
		return 1
	end

	set -l array (command git grep -i -n $argv | fzf --ansi --cycle | string split -m2 ':')

	if count $array >/dev/null
		command nvim "+$array[2]" "$array[1]"
	end
end

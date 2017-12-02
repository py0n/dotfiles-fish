# Defined in /tmp/fish.IPuNi1/G.fish @ line 2
function G --description 'narrow down git-grep' --argument query directory
	if test -z "$directory"
		set directory '.'
	end
	set -l array ( git grep -i -n $query $directory | fzf | string split -m2 ':' )[1..2]
	if count $array
		nvim "+$array[2]" "$array[1]"
	end
end

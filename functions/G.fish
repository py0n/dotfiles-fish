# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.Is8KjH/G.fish @ line 2
function G --description 'narrow down git-grep'
	if not count $argv >/dev/null
		return 1
	end

	set -l array (git grep -i -n $argv | fzf | string split -m2 ':')

	if count $array >/dev/null
		nvim "+$array[2]" "$array[1]"
	end
end

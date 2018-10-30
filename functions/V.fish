# Defined in /tmp/fish.OjxY4o/V.fish @ line 2
function V --description 'fzf git-branch (remote)'
	echo -n (git branch -rvv | string trim | fzf --ansi --cycle | string split ' ')[1]
end

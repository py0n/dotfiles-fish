# Defined in /tmp/fish.D2Utmp/V.fish @ line 2
function V --description 'fzf git-branch (remote)'
	echo -n (git branch -rvv | string trim | fzf | string split ' ')[1]
end

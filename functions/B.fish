# Defined in /tmp/fish.L21HLH/B.fish @ line 2
function B --description 'fzf git-branch'
	echo -n (git branch -avv | string trim | string replace -r '^(remotes/|\* )' '' | fzf | string split ' ')[1]
end

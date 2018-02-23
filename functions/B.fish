# Defined in /tmp/fish.55l7bH/B.fish @ line 2
function B --description 'fzf git-branch (local)'
	echo -n (git branch -vv | string trim | string replace -r '^\* ' '' | fzf | string split ' ')[1]
end

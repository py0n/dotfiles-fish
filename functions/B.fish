# Defined in /tmp/fish.NcsDgr/B.fish @ line 2
function B --description 'fzf git-branch (local)'
	echo -n (git branch -vv | string trim | string replace -r '^\* ' '' | fzf --ansi --cycle | string split ' ')[1]
end

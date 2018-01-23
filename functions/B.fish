# Defined in /tmp/fish.JOuVZb/B.fish @ line 2
function B --description 'fzf git-branch'
	echo -n ( git branch --all | string trim | string replace -r '^(remotes/|\* )' '' | fzf )
end

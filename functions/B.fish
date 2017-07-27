# Defined in /home/yuichirou.ishikawa/.config/fish/functions/B.fish @ line 2
function B --description 'fzf git-branch'
	echo -n ( git branch --all | string sub --start 3 | string replace 'remotes/' '' | fzf )
end

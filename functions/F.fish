# Defined in /tmp/fish.YSu1Qe/F.fish @ line 2
function F --description 'fzf git-ls-files'
	echo -n ( git ls-files | fzf --ansi --cycle)
end

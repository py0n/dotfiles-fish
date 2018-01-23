# Defined in /tmp/fish.8MA89Z/C.fish @ line 2
function C --description 'fzf git-commit'
	echo -n ( git log --full-history --date=format:'%Y/%m/%d %H:%M:%S' --pretty=format:'%h [%ad] %an : %s %d' | fzf | cut -d ' ' -f 1 )
end

# Defined in /tmp/fish.SNRJnm/C.fish @ line 2
function C --description 'fzf git-commit'
	echo -n (git log --full-history --date=format:'%Y/%m/%d %H:%M:%S' --pretty=format:'%h [%ad] %an : %s %d' | fzf --ansi --cycle | string split ' ')[1]
end

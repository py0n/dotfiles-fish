# Defined in /home/yuichirou.ishikawa/.config/fish/functions/c.fish @ line 2
function C --description 'fzf git-commit'
	echo -n ( git log --full-history --date=format:'%Y/%m/%d %H:%M:%S' --pretty=format:'%h [%ad] %an : %s' | fzf | awk '{print $1}' )
end

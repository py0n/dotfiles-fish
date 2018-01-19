# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.dPbxqM/C.fish @ line 2
function C --description 'fzf git-commit'
	echo -n ( git log --full-history --date=format:'%Y/%m/%d %H:%M:%S' --pretty=format:'%h [%ad] %an : %s' | fzf | cut -d ' ' -f 1 )
end

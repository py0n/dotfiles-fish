# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.1Osmrj/B.fish @ line 2
function B --description 'fzf git-branch'
	echo -n ( git branch --all | string trim | string replace 'remotes/' '' | fzf )
end

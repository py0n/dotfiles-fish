# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.iPJ3ms/R.fish @ line 2
function R --description 'fzf ghq list'
	echo -n (ghq root)/(ghq list | fzf --ansi --cycle --layout=reverse-list)
end

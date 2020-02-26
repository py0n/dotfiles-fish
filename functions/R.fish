# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.38UIl6/R.fish @ line 2
function R --description 'fzf ghq list'
	if set --query TMUX; and type --no-functions --quiet fzf-tmux
		set cmd fzf-tmux
	else
		set cmd fzf
	end
	echo -n (ghq root)/(ghq list | command $cmd --ansi --cycle --layout=reverse-list)
end

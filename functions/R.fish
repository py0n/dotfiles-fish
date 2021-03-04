# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.YLFHJp/R.fish @ line 2
function R --description 'fzf ghq list'
	if set --query TMUX; and type --query --no-functions fzf-tmux
		set cmd fzf-tmux
	else
		set cmd fzf
	end
	echo -n (ghq root)/(ghq list | command $cmd --ansi --cycle --layout=reverse-list)
end

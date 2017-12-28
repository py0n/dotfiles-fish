# Defined in /tmp/fish.wB58A7/R.fish @ line 2
function R --description 'fzf ghq list'
	echo -n (git config --global ghq.root)/(ghq list | fzf)
end

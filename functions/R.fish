# Defined in /tmp/fish.cssELv/R.fish @ line 2
function R --description 'fzf ghq list'
	echo -n (ghq root)/(ghq list | fzf)
end

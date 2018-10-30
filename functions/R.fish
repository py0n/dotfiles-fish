# Defined in /tmp/fish.GjSzXO/R.fish @ line 2
function R --description 'fzf ghq list'
	echo -n (ghq root)/(ghq list | fzf --ansi --cycle)
end

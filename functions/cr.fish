# Defined in /tmp/fish.IaoD5R/cr.fish @ line 2
function cr --description 'change repository'
	cd (git config --global ghq.root)/(ghq list | fzf)
end

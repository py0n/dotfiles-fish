# Defined in /tmp/fish.W4WbXg/f.fish @ line 1
function F --description 'fzf git-ls-files'
	echo -n ( git ls-files | fzf )
end

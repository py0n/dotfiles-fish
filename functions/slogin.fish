# Defined in /tmp/fish.Aov2Gz/slogin.fish @ line 1
function slogin --description 'slogin with fzf & ssh-config'
	if count $argv >/dev/null
		command slogin $argv
	else
		slogin (awk '/^Host[[:space:]]+[[:alnum:]_\-]+$/ { print $2 }' $HOME/.ssh/config | fzf)
	end
end

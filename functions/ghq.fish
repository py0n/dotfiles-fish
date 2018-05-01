# Defined in /tmp/fish.ZHa4WV/ghq.fish @ line 2
function ghq
	set -l num (count $argv)
	if [ $num -eq 1 ]
		if [ $argv[1] = "look" ]
			command ghq look (command ghq list | fzf)
		else
			command ghq $argv
		end
	else
		command ghq $argv
	end
end

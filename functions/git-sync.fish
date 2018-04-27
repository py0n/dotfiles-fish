# Defined in /tmp/fish.qQ5RLi/git-sync.fish @ line 2
function git-sync
	# git-sync (fish version)
	#
	# cf. https://qiita.com/masarakki/items/27f2cb456b4801ccb31b
	command git fetch --all --prune

	set -l modifieds (command git status --porcelain --untracked-files=no | string length)

	if count $modifieds
		command git stash
	end

	set -l current (command git branch | string match --entire --regex '^\* ' | string split ' ')[2]

	command git checkout master
	command git pull --rebase

	for b in (command git branch --no-color --merged | string match --entire --invert --regex '^\* ' | string trim)
		command git branch -d $b
	end

	for b in (command git branch --no-color -vv | string match --entire --regex '\[[A-Za-z0-9_\/\.\-]*: gone\]' | string trim)
		command git branch -D  (string split --max 1 ' ' $b)[1]
	end

	if count $modifieds
		if command git checkout $current
			command git stash pop
		else
			command git stash drop
		end
	end
end

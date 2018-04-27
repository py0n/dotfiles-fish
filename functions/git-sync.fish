# Defined in /tmp/fish.P5Ob9Y/git-sync.fish @ line 2
function git-sync
	# git-sync (fish version)
	#
	# cf. https://qiita.com/masarakki/items/27f2cb456b4801ccb31b
	git fetch --all --prune

	set -l modifieds (git status --porcelain --untracked-files=no | string length)

	if count $modifieds
		git stash
	end

	set -l current (git branch | string match --entire --regex '^\* ' | string split ' ')[2]

	git checkout master
	git pull --rebase

	for b in (git branch --no-color --merged | string match --entire --invert --regex '^\* ' | string trim)
		git branch -d $b
	end

	for b in (git branch --no-color -vv | string match --entire --regex '\[[A-Za-z0-9_\/\.\-]*: gone\]' | string trim)
		git branch -D  (string split --max 1 ' ' $b)[1]
	end

	if count $modifieds
		if git checkout $current
			git stash pop
		else
			git stash drop
		end
	end
end

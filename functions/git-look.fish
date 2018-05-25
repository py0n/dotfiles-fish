# Defined in /tmp/fish.JYLmjN/git-look.fish @ line 3
function git-look
	# git-look
	#
	# $HOME/.gitconfig に以下の設定を追加してください
	#
	# ```
	# [alias]
	#     look = !fish -c git-look
	# ```

	set -l repo (command ghq list | fzf)
	set -l root (command ghq root)
	if test -n '$repo'
		cd $root/$repo
		exec fish
	end
end

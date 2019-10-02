# Defined in /tmp/fish.euXZGo/git-co.fish @ line 2
function git-co
	# git-co
	#
	# * 引数が無いときはブランチを選択する
	# * それ以外は通常の git-checkout
	#
	# $HOME/.gitconfig に以下の設定を追加してください
	#
	# ```
	# [alias]
	#     co = !fish -c git-co
	# ```

	if count $argv >/dev/null
		command git checkout $argv
	else
		command git checkout (git branch -vv | string trim | string replace --regex '\A\* ' '' | fzf --ansi --cycle --layout=reverse-list | string split ' ')[1]
	end
end

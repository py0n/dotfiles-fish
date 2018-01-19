# Defined in /Users/yuichirou.ishikawa/.config/fish/functions/build-gotools.fish @ line 2
function build-gotools --description 'Build pt, etc.'
	go get -u github.com/d4l3k/go-pry
	go get -u github.com/monochromegane/the_platinum_searcher/...
	go get -u github.com/motemen/ghq
	go get -u github.com/motemen/gore
	go get -u github.com/nsf/gocode
	go get -u golang.org/x/tools/cmd/...
end

# Defined in /tmp/fish.dbVRxG/build-gotools.fish @ line 2
function build-gotools --description 'Build pt, etc.'
	go get -u github.com/Songmu/make2help/cmd/make2help
	go get -u github.com/d4l3k/go-pry
	go get -u github.com/davecgh/go-spew/spew
	go get -u github.com/golang/dep/cmd/dep
	go get -u github.com/golang/lint/golint
	go get -u github.com/k0kubun/pp
	go get -u github.com/monochromegane/the_platinum_searcher/...
	go get -u github.com/motemen/ghq
	go get -u github.com/motemen/gore
	go get -u github.com/nsf/gocode
	go get -u golang.org/x/tools/cmd/...
end

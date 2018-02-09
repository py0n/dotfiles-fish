# Defined in /var/folders/jd/dp3g4h052llfp2p75h7lq4685nprdw/T//fish.M8fSf6/update-gotools.fish @ line 1
function update-gotools --description 'update tools of go'
	go get -u github.com/Songmu/make2help/cmd/make2help
	go get -u github.com/d4l3k/go-pry
	go get -u github.com/davecgh/go-spew/spew
	go get -u github.com/golang/dep/cmd/dep
	go get -u github.com/golang/lint/golint
	go get -u github.com/jstemmer/gotags
	go get -u github.com/k0kubun/pp
	go get -u github.com/monochromegane/the_platinum_searcher/...
	go get -u github.com/motemen/ghq
	go get -u github.com/motemen/gore
	go get -u github.com/nsf/gocode
	go get -u github.com/rogpeppe/godef
	go get -u golang.org/x/tools/cmd/...
end

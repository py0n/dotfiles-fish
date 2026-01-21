function update-gotools --description 'update tools of go (go install @latest)'
    if not type -q go
        return 1
    end

    go install github.com/Songmu/make2help/cmd/make2help@latest
    go install github.com/d4l3k/go-pry@latest
    go install github.com/davecgh/go-spew/spew@latest
    go install golang.org/x/lint/golint@latest
    go install github.com/jstemmer/gotags@latest
    go install github.com/k0kubun/pp@latest
    go install github.com/monochromegane/the_platinum_searcher/...@latest
    go install github.com/motemen/ghq@latest
    go install github.com/motemen/gore@latest
    go install github.com/nsf/gocode@latest
    go install github.com/rogpeppe/godef@latest
    go install golang.org/x/tools/cmd/...@latest
end

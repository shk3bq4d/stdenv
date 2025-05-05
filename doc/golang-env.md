go version
go fmt ./... # beautify reformat code


# github release
https://github.com/goreleaser/goreleaser
https://github.com/goreleaser/goreleaser/releases
cd ~/go/bin/ && wget https://github.com/goreleaser/goreleaser/releases/download/v2.9.0/goreleaser_Linux_x86_64.tar.gz && tar xf goreleaser_Linux_x86_64.tar.gz && rm goreleaser_Linux_x86_64.tar.gz
git tag 1.3.1-shk3bq4d-2 -m release
go install github.com/goreleaser/goreleaser@latest
goreleaser release --snapshot --clean # local release
The minimum permissions the GITHUB_TOKEN should have to run this are write:packages
https://github.com/settings/tokens/new?scopes=repo,write:packages
tag=1.3.1-shk3bq4d-4; git tag $tag -m release && git push origin $tag && GITHUB_TOKEN="" GPG_FINGERPRINT=HEHE goreleaser release --clean

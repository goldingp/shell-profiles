# Golang
if [[ ! ${GOPATH} ]]; then
	export GOPATH=${HOME}/go:${HOME}/repos
	PATH=${HOME}/go/bin:${PATH}
fi

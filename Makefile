APP := $(shell basename $(shell git remote get-url origin))
REGISTRY := lyalyukev
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS ?= linux
TARGETARCH ?= amd64


format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/lyalyukev/tbot/cmd.appVersion=${VERSION}

linux: format get
	CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -v -o kbot

arm: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=arm64 go build -v -o kbot

macos: format get
	CGO_ENABLED=0 GOOS=darwin GOARCH=${TARGETARCH} go build -v -o kbot

windows: format get
	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o kbot

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}  --build-arg TARGETARCH=${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}
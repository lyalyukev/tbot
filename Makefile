APP := tbot
REGISTRY := ghcr.io/lyalyukev
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS ?=linux
TARGETARCH ?=amd64


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
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/lyalyukev/tbot/cmd.appVersion=${VERSION}

arm: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=arm64 go build -v -o kbot -ldflags "-X="github.com/lyalyukev/tbot/cmd.appVersion=${VERSION}

macos: format get
	CGO_ENABLED=0 GOOS=${TARGETOS}  GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/lyalyukev/tbot/cmd.appVersion=${VERSION}

windows: format get
	CGO_ENABLED=0 GOOS=${TARGETOS}  GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/lyalyukev/tbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}

clean:
	rm -rf kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETOS}-${TARGETARCH}
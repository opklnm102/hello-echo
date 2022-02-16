TAG := $(shell git branch --show-current | sed -e "s/\//-/g")-$(shell git rev-parse HEAD)
BIN=hello-echo
IMAGE=opklnm102/$(BIN)

.DEFAULT_GOAL := help

.PHONY: setup
setup:
	go get github.com/Songmu/make2help/cmd/make2help

## Install dependencies
.PHONY: install
install:
	go mod download

## go build
.PHONY: build
build: install
	go build -o bin/${BIN} cmd/server/main.go

## Run tests
.PHONY: test
test: install
	./go.test.sh

## Build image
.PHONY: image
image:
	docker build -t $(IMAGE):$(TAG) .

## Push image
.PHONY: deploy
deploy: image
	docker push $(IMAGE):$(TAG)

## Run container
.PHONY: run-container
run-container: image
	docker run $(IMAGE):$(TAG)

## Run bin
.PHONY: run
run:
	./bin/$(BIN)

## Clean bin
.PHONY: clean
clean:
	rm bin/$(BIN)

## lint
.PHONY: lint
lint:
	go vet ./...
	for pkg in $$(go list ./...); do \
	  golint $$pkg; \
	done

## Show help
.PHONY: help
help:
	@make2help $(MAKEFILE_LIST)

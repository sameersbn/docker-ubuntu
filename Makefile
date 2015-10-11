all: build

build:
	@docker build --tag=${USER}/ubuntu:latest .

release: build
	@docker build --tag=quay.io/${USER}/ubuntu:$(shell cat VERSION) .

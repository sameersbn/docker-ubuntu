all: build

build:
	@docker build --tag=quay.io/sameersbn/ubuntu:latest .

release: build
	@docker build --tag=quay.io/sameersbn/ubuntu:$(shell cat VERSION) .

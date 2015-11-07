all: build

build:
	@docker build --tag=sameersbn/ubuntu:latest .

release: build
	@docker build --tag=sameersbn/ubuntu:$(shell cat VERSION) .

all: build

build:
	@docker build --tag=${USER}/ubuntu:latest .

base:
	@docker pull ubuntu:14.04

rebuild: base
	@docker build --tag=${USER}/ubuntu:latest .

release: rebuild
	@docker build --tag=${USER}/ubuntu:14.04.$(shell date +%Y%m%d) .

all: build

build:
	@docker build --tag=${USER}/ubuntu .

base:
	@docker pull ubuntu:12.04

rebuild: base
	@docker build --tag=${USER}/ubuntu:12.04 .

release: rebuild
	@docker build --tag=${USER}/ubuntu:12.04.$(shell date +%Y%m%d) .

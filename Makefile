DOCKER_ANSIBLE_VERSION = '1.0.4'
build:
	docker build --build-arg USER=$(USER) -t ansible:v7 .

run:
	docker run --rm -it -v $(shell pwd)/application:/application/ansible ansible:v7 /bin/bash
	
elastic:
	ansible-galaxy install elastic.elasticsearch,6.4.0


GITCOMMIT := $(shell git rev-parse --short=7 HEAD 2>/dev/null)
NAME=dev

all: build

build:
	docker build -t danberg/${NAME}:${GITCOMMIT} .

push:
	@echo "==> Publishing danberg/${NAME}:$(GITCOMMIT)"
	@docker tag danberg/${NAME}:$(GITCOMMIT) danberg/${NAME}:latest
	@docker push danberg/${NAME}:$(GITCOMMIT)
	@docker push danberg/${NAME}:latest
	@echo "==> Your image is now available at danberg/${NAME}:$(GITCOMMIT)"

run: kill
	docker run -it -h dev -d --net=host --rm -v /var/run/docker.sock:/var/run/docker.sock -v /home/danberg/code:/home/danberg/code -v /home/danberg/.ssh:/home/fatih/.ssh -v /home/danberg/.zsh_private:/home/danberg/.zsh_private -v /home/danberg/.zsh_history:/home/fatih/.zsh_history --cap-add=SYS_PTRACE --security-opt seccomp=unconfined --privileged --name dev danberg:dev 

ssh:
	mosh --no-init --ssh="ssh -o StrictHostKeyChecking=no -i ~/.ssh/jump2_rsa -p 3222" danberg@localhost -- tmux new-session -AD -s main

kill:
	docker kill dev | true


.PHONY: all build run kill

.PHONY: image run

GHC_COMMIT:=$(shell sh ghc-commit.sh)
GHC_DOCKER_REV:=$(shell sh ghc-docker-rev.sh)

image:
	@echo GHC_COMMIT=$(GHC_COMMIT)
	@echo GHC_DOCKER_REV=$(GHC_DOCKER_REV)
	docker build \
	  --build-arg GHC_DOCKER_REV=$(GHC_DOCKER_REV) \
	  --build-arg GHC_COMMIT=$(GHC_COMMIT) \
	  -t ghc-docker-dev .

run:
	# The SSH socket mount takes care of your SSH credentials for `git pull` and `git push`.
	docker run --mount type=bind,source=${SSH_AUTH_SOCK},target=/ssh-agent --env SSH_AUTH_SOCK=/ssh-agent -it ghc-docker-dev bash

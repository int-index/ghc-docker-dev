.PHONY: image run

GHC_COMMIT:=$(shell ./ghc-commit.sh)
GHC_DOCKER_REV:=$(shell ./ghc-docker-rev.sh)

image:
	@echo GHC_COMMIT=$(GHC_COMMIT)
	@echo GHC_DOCKER_REV=$(GHC_DOCKER_REV)
	docker build \
	  --build-arg GHC_DOCKER_REV=$(GHC_DOCKER_REV) \
	  --build-arg GHC_COMMIT=$(GHC_COMMIT) \
	  -t ghc-docker-dev .

run:
	docker run -it ghc-docker-dev

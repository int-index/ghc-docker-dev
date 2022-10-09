#!/bin/sh
curl -sSf "https://gitlab.haskell.org/ghc/ghc/-/raw/master/.gitlab-ci.yml" | yq -r '.variables.DOCKER_REV'

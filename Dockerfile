ARG GHC_DOCKER_REV
FROM registry.gitlab.haskell.org/ghc/ci-images/x86_64-linux-deb10:$GHC_DOCKER_REV
ARG GHC_COMMIT
USER ghc
ENV PATH=${PATH}:/home/ghc/.local/bin:/opt/ghc/9.6.4/bin
RUN sudo apt update && sudo apt install -y bash-completion ripgrep
RUN git clone -j8 --recurse-submodules https://gitlab.haskell.org/ghc/ghc.git && cd ghc && git reset --hard $GHC_COMMIT
WORKDIR /home/ghc/ghc
RUN cd hadrian && cabal install hadrian fast-tags
RUN ./boot && ./configure && hadrian -j
RUN fast-tags -R compiler ghc libraries/base libraries/template-haskell/

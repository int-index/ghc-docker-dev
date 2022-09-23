FROM registry.gitlab.haskell.org/ghc/ci-images/x86_64-linux-deb10:9e4c540d9e4972a36291dfdf81f079f37d748890
USER ghc
ENV PATH=${PATH}:/home/ghc/.cabal/bin:/opt/ghc/9.2.2/bin
RUN sudo apt update && sudo apt install -y bash-completion ripgrep
RUN git clone --recurse-submodules https://gitlab.haskell.org/ghc/ghc.git
WORKDIR /home/ghc/ghc
RUN cd hadrian && cabal install hadrian
RUN ./boot && ./configure && hadrian -j --flavour=Quick

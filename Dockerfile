ARG GHC_DOCKER_REV
FROM registry.gitlab.haskell.org/ghc/ci-images/x86_64-linux-deb12:$GHC_DOCKER_REV
ARG GHC_COMMIT
USER ghc
ENV PATH=${PATH}:/home/ghc/.local/bin:/opt/ghc/9.6.4/bin
RUN sudo apt update && sudo apt install -y bash-completion less ripgrep neovim tmux
RUN git clone -j8 --recurse-submodules https://gitlab.haskell.org/ghc/ghc.git && cd ghc && git reset --hard $GHC_COMMIT && git remote set-url origin git@gitlab.haskell.org:ghc/ghc.git
WORKDIR /home/ghc/ghc
RUN cd hadrian && cabal install hadrian fast-tags
RUN ./boot && ./configure
RUN hadrian -j
RUN hadrian -j --freeze1 test --only="T12919 haddockHtmlTest"
RUN hadrian -j --freeze1 docs --docs=no-sphinx-pdfs
RUN echo ":q" | hadrian/ghci
RUN fast-tags -R compiler ghc libraries/base libraries/template-haskell/
RUN sudo apt install -y zsh && git clone https://github.com/ohmyzsh/ohmyzsh.git /home/ghc/.oh-my-zsh && sudo usermod --shell $(which zsh) ghc
COPY assets/.zshrc /home/ghc/.zshrc
COPY assets/ghc-docker-dev.zsh-theme /home/ghc/.oh-my-zsh-custom/themes/ghc-docker-dev.zsh-theme

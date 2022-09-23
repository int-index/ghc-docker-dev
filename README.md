# Build
```
docker build -t ghc-docker-dev .
```

# Run
```
docker run --mount type=bind,source=$SSH_AUTH_SOCK,target=/ssh-agent --env SSH_AUTH_SOCK=/ssh-agent -it ghc-docker-dev bash
```

The SSH socket mount takes care of your SSH credentials for `git pull` and `git push`.

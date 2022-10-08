curl -sSf "https://gitlab.haskell.org/api/v4/projects/1/repository/commits" | jq -r '.[0].id'

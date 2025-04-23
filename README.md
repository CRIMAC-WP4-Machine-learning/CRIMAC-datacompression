# CRIMAC-datacompression
Data compression using Dockerized Korona


## Build container
`docker build --build-arg=commit_sha=$(git rev-parse HEAD) --build-arg=version_number=$(git describe --tags) --no-cache --tag crimac-compression .`

## Test



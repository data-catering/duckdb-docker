#!/usr/bin/env bash

platforms="linux/amd64,linux/arm64"

echo "Getting latest tag version from duckdb"
duckdb_version=$(git -C build/duckdb describe --tags --abbrev=0)
echo "Building for duckdb version: ${duckdb_version}"

docker run --privileged --rm tonistiigi/binfmt --install all
docker buildx create --use --name builder
docker buildx inspect --bootstrap builder

docker buildx build \
  --platform "$platforms" \
  --build-arg "DUCKDB_VERSION=${duckdb_version}" \
  -t datacatering/duckdb:"${duckdb_version}" --push .

echo "Done!"

#!/usr/bin/env bash

echo "Getting latest tag version from duckdb"
duckdb_version=$(git -C build/duckdb describe --tags --abbrev=0)
echo "Building for duckdb version: ${duckdb_version}"

for i in amd64,amd64 arm64,aarch64 ; do
  platform=${i%,*};
  arch=${i#*,};
  echo "Building docker image for platform: ${platform}, arch: ${arch}"
  docker build \
    --platform "${platform}" \
    --build-arg "DUCKDB_VERSION=${duckdb_version}" \
    --build-arg "ARCH=${arch}" \
    -t datacatering/duckdb:"${duckdb_version}" --push .
done

echo "Done!"

#!/usr/bin/env bash

declare -A platforms
platforms[amd64]="amd64"
platforms[arm64]="aarch64"

echo "Getting latest tag version from duckdb"
duckdb_version=$(git -C build/duckdb describe --tags --abbrev=0)

for platform in "${!platforms[@]}"; do
    echo ${platform} ${platforms[${platform}]}
    echo "Building docker image for platform: ${platform}"
    docker build \
      --platform "${platform}" \
      --build-arg "DUCKDB_VERSION=${duckdb_version}" \
      --build-arg "ARCH=${platforms[${platform}]}" \
      -t datacatering/duckdb:"${duckdb_version}" \
      --push .
done

echo "Done!"

#!/usr/bin/env bash

set -e

platforms="linux/amd64,linux/arm64"

# Check if duckdb repo exists, clone if not
if [ ! -d "build/duckdb" ]; then
  echo "Cloning duckdb repository..."
  mkdir -p build
  git clone --depth=1 https://github.com/duckdb/duckdb.git build/duckdb
  git -C build/duckdb fetch --tags
fi

echo "Getting latest tag version from duckdb"
duckdb_rev_list=$(git -C build/duckdb rev-list --tags --max-count=1)
duckdb_version=$(git -C build/duckdb describe --tags ${duckdb_rev_list})
image_name=datacatering/duckdb:"${duckdb_version}"

if [ -z "$(DOCKER_CLI_EXPERIMENTAL=enabled docker manifest inspect "$image_name" 2> /dev/null)" ]; then
  echo "Building for duckdb version: ${duckdb_version}"

  docker run --privileged --rm tonistiigi/binfmt --install all
  docker buildx create --use --name builder
  docker buildx inspect --bootstrap builder

  docker buildx build \
    --platform "$platforms" \
    --build-arg "DUCKDB_VERSION=${duckdb_version}" \
    -t "$image_name" --push .

  # Extract current version from README.md
  current_version=$(grep -o 'datacatering/duckdb:v[0-9]\+\.[0-9]\+\.[0-9]\+' README.md | head -1 | cut -d':' -f2)
  
  echo "needs_readme_update=true" >> $GITHUB_OUTPUT
  echo "latest_version=${duckdb_version}" >> $GITHUB_OUTPUT
  echo "current_version=${current_version}" >> $GITHUB_OUTPUT

  echo "Updating README.md from ${current_version} to ${duckdb_version}"
  sed "s/${current_version}/${duckdb_version}/g" README.md > README.md.tmp && mv README.md.tmp README.md
  echo "README.md updated successfully"

  echo "Done!"
else
  echo "Latest duckdb image version already exists, version: ${duckdb_version}"
  echo "needs_readme_update=false" >> $GITHUB_OUTPUT
fi



FROM ubuntu:24.10 AS base
ARG DUCKDB_VERSION=v1.0.0

FROM base AS base-amd64
ARG DUCKDB_ARCH=amd64

FROM base AS base-arm64
ARG DUCKDB_ARCH=aarch64

FROM base-$TARGETARCH
RUN apt-get update  \
    && apt-get install -y curl unzip \
    && curl -L -o duckdb_cli.zip "https://github.com/duckdb/duckdb/releases/download/${DUCKDB_VERSION}/duckdb_cli-linux-${DUCKDB_ARCH}.zip" \
    && unzip duckdb_cli.zip

ENTRYPOINT [ "./duckdb" ]

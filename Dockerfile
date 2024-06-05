FROM ubuntu:24.10

ARG DUCKDB_VERSION=v1.0.0
ARG ARCH=aarch64

RUN apt-get update && apt-get install -y curl unzip

RUN curl -L -o duckdb_cli.zip "https://github.com/duckdb/duckdb/releases/download/${DUCKDB_VERSION}/duckdb_cli-linux-${ARCH}.zip"
RUN unzip duckdb_cli.zip

ENTRYPOINT [ "./duckdb" ]

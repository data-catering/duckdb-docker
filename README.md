# duckdb-docker

Creation of DuckDB Docker image. Image gets pushed to [DockerHub](https://hub.docker.com/repository/docker/datacatering/duckdb/general).

GitHub action for creating the image checks each day for the latest version of DuckDB and will push if a new version is available.

## Run

```shell
docker run -it datacatering/duckdb:v1.1.3
```

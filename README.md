# duckdb-docker

Creation of DuckDB Docker image. Image gets pushed to [DockerHub](https://hub.docker.com/repository/docker/datacatering/duckdb/general).

## Run

```shell
docker run -it datacatering/duckdb:v1.0.0
```

## Improvements

- Cron schedule for github action to check if there is a new release tag
- Only push new image if there is a new release tag

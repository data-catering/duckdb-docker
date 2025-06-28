# duckdb-docker

Creation of DuckDB Docker image. Image gets pushed to [DockerHub](https://hub.docker.com/repository/docker/datacatering/duckdb/general).

GitHub action for creating the image checks each day for the latest version of DuckDB and will push if a new version is available.

## Run

```shell
docker run -it datacatering/duckdb:v1.3.1
```

### Run with UI

```shell
docker run --rm --net host -it datacatering/duckdb:v1.3.1 -ui
```

Then open [http://localhost:4213](http://localhost:4213).
If using Docker Desktop, ensure host networking is enabled as [seen here](https://docs.docker.com/engine/network/drivers/host/#docker-desktop).

Docker ArchivesSpace builds
---------------------------

**Automated builds**

- docker hub integration (build on push)
- also trigger from _archivesspace_/archivesspace to build on hub
- webhook from hub to deploy via docker on server (captain webhook)

**Manual builds**

Clone this repository, `cd` to it and:

```
docker build --no-cache --rm=true -t archivesspace/build:latest . 
```

**Running**

Use `archivesspace/build:latest` in place of `markcooper/archivesspace-build` for local builds.

```
# background mode
docker run --name build -d \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  markcooper/archivesspace-build

# foreground mode
docker run --name build -i -t \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  markcooper/archivesspace-build

# foreground mode and access container
docker run --name build -i -t \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  markcooper/archivesspace-build /bin/bash
```

**With MySQL**

```
# pull and run the official mysql docker image
docker run -d \
  -p 3306:3306 \
  --name mysql \
  -e MYSQL_ROOT_PASSWORD=123456 \
  -e MYSQL_DATABASE=archivesspace \
  -e MYSQL_USER=archivesspace \
  -e MYSQL_PASSWORD=archivesspace \
  mysql

# foreground mode
docker run --name build -i -t \
  -p 8080:8080 \
  -p 8081:8081 \
  -p 8089:8089 \
  -p 8090:8090 \
  -e ARCHIVESSPACE_DB_TYPE=mysql \
  --link mysql:db \
  markcooper/archivesspace-build
```

---
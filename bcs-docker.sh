#!/bin/bash

# Check for running container, if so stop and remove and clean otherwise
if [ "$(docker ps -q -f name=bcs-docker)" ]; then
  echo Stop running container and cleanup
  docker stop bcs-docker
  docker rm bcs-docker
  docker system prune -f
fi

echo Run new container
docker run -d \
  --name=bcs-docker \
  --restart unless-stopped \
  --net=host \
  -v ~/bcs-docker/repo/conf:/opt/projektron/bcs/server/conf \
  -v ~/bcs-docker/repo/conf_local_docker:/opt/projektron/bcs/server/conf_local \
  -v ~/bcs-docker/log:/opt/projektron/bcs/server/log \
  -v ~/bcs-docker/data/files:/opt/projektron/bcs/server/data/files \
  -v ~/bcs-docker/data/ftindex:/opt/projektron/bcs/server/data/FTIndex \
  -v ~/bcs-docker/repo/tomcat/conf85_docker:/usr/local/tomcat/conf \
  -p 8080:8080 \
  bcs

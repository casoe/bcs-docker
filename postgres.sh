#!/bin/bash

USER="bcs"

# Check if pgdata volume exists
if [ ! "$(docker volume ls -q -f name=pgdata)" ]; then
    # If not create one
    echo Create docker volume
    docker volume create pgdata
fi

docker run -d \
  --name=postgres \
  --restart=always \
  -p 5432:5432 \
  -v pgdata:/var/lib/postgresql/data \
  -v ~/bcs-docker/restore/db:/restore \
  -e POSTGRES_USER=$USER \
  -e POSTGRES_PASSWORD=$USER \
  -e POSTGRES_DB=$USER \
  --health-cmd "pg_isready -U $USER" \
  --health-interval 5s \
  --health-retries 10 \
  --health-start-period 10s \
  --health-timeout 2s \
  postgres:14-bullseye \
  -c shared_buffers=4GB \
  -c effective_cache_size=8GB \
  -c work_mem=10MB \
  -c max_wal_size=1GB

echo Postgres-Dump restore with:
echo docker exec -i postgres pg_restore -v -c -j 12 -d bcs -U bcs -Fd /restore/

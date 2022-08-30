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
  -v restore/db:/restore \
  -e POSTGRES_USER=$USER \
  -e POSTGRES_PASSWORD=$USER \
  -e POSTGRES_DB=$USER \
  --health-cmd "pg_isready -U $USER" \
  --health-interval 5s \
  --health-retries 10 \
  --health-start-period 10s \
  --health-timeout 2s \
  postgres:13-bullseye \
  -c shared_buffers=2048MB \
  -c effective_cache_size=4096MB

echo Postgres-Dump restore with:
echo docker exec -i postgres pg_restore -v -c -j 12 -d bcs -U bcs -Fd /restore/

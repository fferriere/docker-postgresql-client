#!/bin/bash

IMAGE='fferriere/postgresql-client'
if [ -n "$FFERRIERE_PG_CLIENT_IMAGE" ]; then
    IMAGE="$FFERRIERE_PG_CLIENT_IMAGE"
fi

SERVER_NAME='fferriere-postgresql-server'
if [ -n "$FFERRIERE_PG_SERVER_NAME" ]; then
    SERVER_NAME="$FFERRIERE_PG_SERVER_NAME"
fi

NB_ROWS=$(docker ps | grep -w "$SERVER_NAME" | wc -l)
if [ "$NB_ROWS" -eq 0 ]; then
    echo "Container '$SERVER_NAME' doesn't exists !" >&2
    exit 1
fi

DOCKER_ARGS='--rm -i';
if [ -t 0 ]; then
    DOCKER_ARGS="$DOCKER_ARGS -t"
fi

docker run $DOCKER_ARGS \
  --volumes-from $SERVER_NAME \
  $IMAGE psql $@

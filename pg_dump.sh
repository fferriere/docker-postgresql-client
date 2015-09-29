#!/bin/bash

IMAGE='fferriere/postgresql-client'
if [ -n "$FFERRIERE_PG_CLIENT_IMAGE" ]; then
    IMAGE="$FFERRIERE_PG_CLIENT_IMAGE"
fi

DOCKER_ARGS='--rm -i';
if [ -t 0 ]; then
    DOCKER_ARGS="$DOCKER_ARGS -t"
fi

if [ -n "$FFERRIERE_PG_CLIENT_DOCKER_ARGS" ]; then
    DOCKER_ARGS="$DOCKER_ARGS $FFERRIERE_PG_CLIENT_DOCKER_ARGS"
fi

docker run $DOCKER_ARGS \
  $IMAGE pg_dump $@

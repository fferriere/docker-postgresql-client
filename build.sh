#!/bin/bash

THIS_PATH=$(dirname $(realpath $0))

NAME='fferriere/postgresql-client'
if [ -n "$FFERRIERE_PG_CLIENT_IMAGE" ]; then
    NAME="$FFERRIERE_PG_CLIENT_IMAGE"
fi

docker build -t $NAME $@ $THIS_PATH/.

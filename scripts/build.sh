#!/usr/bin/env bash

set -e

full="sondrelg/uvicorn-gunicorn:$NAME"
slim="sondrelg/uvicorn-gunicorn:$NAME-slim"

DOCKERFILE="$NAME"

if [ "$NAME" == "latest" ] ; then
    DOCKERFILE="python3.9"
fi

docker build -t "$full" --file "./docker-images/${DOCKERFILE}.dockerfile" "./docker-images/"
docker build -t "$slim" --file "./docker-images/${DOCKERFILE}-slim.dockerfile" "./docker-images/"

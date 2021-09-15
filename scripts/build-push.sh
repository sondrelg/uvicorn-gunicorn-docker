#!/usr/bin/env bash

set -e

full="sondrelg/uvicorn-gunicorn:$NAME"
full_date="${full}-$(date -I)"
slim="${full}-slim"
slim_date="${full}-slim-$(date -I)"

bash scripts/build.sh

docker tag "$full" "$full_date"
docker tag "$slim" "$slim_date"

bash scripts/docker-login.sh

docker push "$full"
docker push "$slim"
docker push "$full_date"
docker push "$slim_date"

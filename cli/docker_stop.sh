#!/bin/sh
set -e

docker rm -f $(docker ps -aq);
docker system prune --volumes;
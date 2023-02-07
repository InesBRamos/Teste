#!/bin/sh
set -e

docker stack rm docker-coaching;

docker system prune --volumes;

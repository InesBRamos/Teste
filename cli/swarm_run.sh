#!/bin/sh
set -e

mkdir -p data/db/;

if [ -f "./.env" ]
then
	set -o allexport;
  . ./.env;
  set +o allexport
fi

docker compose -f ./docker-stack.yml build --pull;
docker compose -f ./docker-stack.yml pull --ignore-pull-failures;

docker swarm init || true;

docker stack deploy -c ./docker-stack.yml docker-coaching;

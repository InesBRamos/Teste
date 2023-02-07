#!/bin/sh
set -e

mkdir -p data;

docker compose -f docker-compose.yml -p docker-coaching up --build -d;
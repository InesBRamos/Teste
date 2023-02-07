#!/bin/sh
set -e

mkdir -p data/db/;

docker network create dockerCoaching;

docker run --network=dockerCoaching -e MONGO_INITDB_ROOT_USERNAME=admin -e MONGO_INITDB_ROOT_PASSWORD=admin -v ./data/db/:/data/db/ --name db -d mongo:4;

docker build -f ./microservice/Dockerfile --pull -t inserter:latest ./microservice;
docker run --network=dockerCoaching -d --restart unless-stopped -e MONGODB_CONNSTRING=mongodb://admin:admin@db --name inserter inserter:latest;

docker run --network=dockerCoaching -e ME_CONFIG_BASICAUTH_USERNAME=user -e ME_CONFIG_BASICAUTH_PASSWORD=pw -e ME_CONFIG_MONGODB_ENABLE_ADMIN="true" -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin -e ME_CONFIG_MONGODB_ADMINPASSWORD=admin -e ME_CONFIG_MONGODB_SERVER=db -e ME_CONFIG_MONGODB_PORT=27017 -p 9000:8081 --name db-gui -d mongo-express:latest;
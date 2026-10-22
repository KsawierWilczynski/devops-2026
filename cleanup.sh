#!/bin/sh

docker stop assignment-db
docker rm assignment-db

docker network rm assignment-network

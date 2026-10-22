#!/bin/sh

docker network rm assignment-network

docker stop assignment-db
docker rm assignment-db

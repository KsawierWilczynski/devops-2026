#!/bin/sh

docker stop assignment-db
docker rm assignment-db

docker stop seeder
docker rm seeder

docker network rm assignment-network

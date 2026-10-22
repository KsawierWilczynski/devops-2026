#!/bin/sh

set -e

# Pre-requisites
docker build --target agent -t assignment-agent:1.0 .
docker build --target seeder -t assignment-seeder:1.0 .

docker pull postgres:latest
docker pull docker/mcp-gateway:latest

# Create network
docker network create assignment-network

# Start postgres database
docker run -d --network assignment-network --name assignment-db -e POSTGRES_USER=assignment -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=verycooldata postgres

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
docker run -d --network assignment-network --name assignment-db -p 5432:5432 -e POSTGRES_USER=assignment -e POSTGRES_PASSWORD=secret -e POSTGRES_DB=verycooldata postgres
sleep 2

# Start seeder
docker run -d --network assignment-network --name seeder -e SQLITE_FILE=/app/Chinook.db -e DATABASE_URL=postgres://assignment:secret@assignment-db:5432/verycooldata assignment-seeder:1.0

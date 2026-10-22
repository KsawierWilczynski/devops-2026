#!/bin/sh

set -e

# Pre-requisites
docker build --target agent -t assignment-agent:1.0 .
docker build --target seeder -t assignment-seeder:1.0 .

docker pull postgres:17.11-alpine3.23
docker pull docker/mcp-gateway:latest

# Create network
docker network create assignment-network

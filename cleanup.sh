#!/bin/sh

docker stop assignment-db
docker rm -v assignment-db

docker stop seeder
docker rm -v seeder

docker stop mcp-gateway
docker rm -v mcp-gateway

docker stop ai-agent
docker rm -v ai-agent

docker network rm assignment-network

docker image rm assignment-agent:1.0
docker image rm assignment-seeder:1.0
docker image rm postgres
docker image rm docker/mcp-gateway

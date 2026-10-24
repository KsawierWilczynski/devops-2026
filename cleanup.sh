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
# For some reason docker doesn't seem to see the proper image name for mcp/cockroachdb ?
docker image rm sha256:4863594a246c6f86a5c4c87383a679353e9a6b4d85c3327c48464669cd236b1e

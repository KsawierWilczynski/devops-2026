#!/bin/sh

docker stop assignment-db
docker rm assignment-db

docker stop seeder
docker rm seeder

docker stop mcp-gateway
docker rm mcp-gateway

docker stop ai-agent
docker rm ai-agent

docker network rm assignment-network

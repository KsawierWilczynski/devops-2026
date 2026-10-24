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
sleep 2

# Start seeder
docker run --network assignment-network --name seeder -v "./Chinook.db:/app/Chinook.db" -e SQLITE_FILE=/app/Chinook.db -e DATABASE_URL=postgres://assignment:secret@assignment-db:5432/verycooldata assignment-seeder:1.0

# Start MCP Gateway
docker run -d --network assignment-network --name mcp-gateway -v "/var/run/docker.sock:/var/run/docker.sock" -v "./mcp_config.yaml:/mcp_config.yaml" -v "./mcp_secret.env:/run/secrets/database-url" docker/mcp-gateway --transport=sse --secrets=/run/secrets/database-url --allow-unauthenticated --servers=cockroachdb --tools=execute_query --config=/mcp_config.yaml
sleep 2

# Start AI Agent
docker run -d --network assignment-network --name ai-agent -v "./secret.ollama-api-key:/run/secrets/openai-api-key" -e MCP_SERVER_URL=http://mcp-gateway:8811/sse -e DATABASE_DIALECT=PostgreSQL -e QUESTION="What are the top 3 albums by sales?" -e OPENAI_API_BASE_URL=https://ollama.com/v1 -e OPENAI_MODEL_NAME=gpt-oss:20b assignment-agent:1.0

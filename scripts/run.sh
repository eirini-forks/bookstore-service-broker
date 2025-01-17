#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SCRIPT_DIR="${ROOT_DIR}/scripts"

./gradlew assemble
docker build --build-arg JAR_FILE=build/libs/bookstore-service-broker-0.0.1.BUILD-SNAPSHOT.jar -t broker -f deploy/docker/Dockerfile .

echo "==========================================================="
echo "Broker URL will be http://sample-broker:8080"
echo "username/password is admin/supersecret"
echo "==========================================================="

docker run --network kind --name sample-broker broker

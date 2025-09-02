#!/bin/bash

# Аргументы по умолчанию
COMPOSE_ARGS="-f jenkins.yml -p jenkins"

# Останавливаем и чистим все старые контейнеры
echo "Stopping and removing old containers..."
docker compose $COMPOSE_ARGS down -v --remove-orphans

# Сборка системы
echo "Building containers..."
docker compose $COMPOSE_ARGS build --no-cache

echo "Starting containers..."
docker compose $COMPOSE_ARGS up -d

# Ждем запуска контейнеров
echo "Waiting for containers to start..."
sleep 10

# Модульное тестирование
echo "Running unit tests..."
docker compose $COMPOSE_ARGS run --no-deps --rm -e ENV=UNIT identidock
ERR=$?

# Выполнение тестирования системы, если модульное тестирование завершилось успешно
if [ $ERR -eq 0 ]; then
  IP=$(docker inspect -f {{.NetworkSettings.IPAddress}} jenkins_identidock_1)
  CODE=$(curl -sL -w "%{http_code}" $IP:9090/monster/bla -o /dev/null) || true
  if [ $CODE -eq 200 ]; then
    echo "Test passed - Tagging"
    HASH=$(git rev-parse --short HEAD)
    docker tag -f jenkins_identidock amouat/identidock:$HASH
    docker tag -f jenkins_identidock amouat/identidock:newest
    echo "Pushing"
    docker login -e joe@bloggs.com -u jbloggs -p jbloggs123
    docker push amouat/identidock:$HASH
    docker push amouat/identidock:newest
  else
    echo "Site returned " $CODE
    ERR=1
  fi
fi

# Останавливаем и чистим контейнеры
echo "Cleaning up..."
docker compose $COMPOSE_ARGS down -v --remove-orphans

exit $ERR
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
    echo "Running integration tests..."
    # Получаем IP контейнера
    CONTAINER_ID=$(docker compose $COMPOSE_ARGS ps -q identidock)
    IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $CONTAINER_ID)

    # Тестируем endpoint
    CODE=$(curl -s -o /dev/null -w "%{http_code}" "http://$IP:9090/monster/bla" || echo "500")

    if [ "$CODE" -ne 200 ]; then
        echo "Site returned $CODE"
        ERR=1
    else
        echo "Integration test passed - HTTP 200 OK"
    fi
fi

# Останавливаем и чистим контейнеры
echo "Cleaning up..."
docker compose $COMPOSE_ARGS down -v --remove-orphans

exit $ERR
# Аргументы по умолчанию
COMPOSE_ARGS="-f jenkins.yml -p jenkins"

# Останавливаем и чистим все старые контейнеры
docker compose $COMPOSE_ARGS stop
docker compose $COMPOSE_ARGS rm --force -v

# Сборка системы
docker compose $COMPOSE_ARGS build --no-cache
docker compose $COMPOSE_ARGS up -d

# Ждем запуска контейнеров
sleep 10

# Модульное тестирование
docker compose $COMPOSE_ARGS run --no-deps --rm -e ENV=UNIT identidock
ERR=$?

# Выполнение тестирования системы, если модульное тестирование завершилось успешно
if [ $ERR -eq 0 ]; then
    IP=$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' jenkins_identidock_1)
    CODE=$(curl -sL -w "%{http_code}" "http://$IP:9090/monster/bla" -o /dev/null) || true
    if [ $CODE -ne 200 ]; then
        echo "Site returned $CODE"
        ERR=1
    fi
fi

# Останавливаем и чистим контейнеры
docker compose $COMPOSE_ARGS stop
docker compose $COMPOSE_ARGS rm --force -v

exit $ERR
# Аргументы по умолчанию
COMPOSE_ARGS=" -f /docker/identijenk/jenkins.yml -p jenkins "

# Останавливаем и чистим все старые контейнеры
sudo docker-compose $COMPOSE_ARGS stop
sudo docker-compose $COMPOSE_ARGS rm --force -v

# Сборка системы
sudo docker-compose $COMPOSE_ARGS build --no-cache
sudo docker-compose $COMPOSE_ARGS up -d

# Модульное тестирование
sudo docker-compose $COMPOSE_ARGS run --no-deps --rm -e ENV=UNIT identidock ERR=$?

# Выполнение тестирования системы, если модульное тестирование завершилось успешно
if [ $ERR -eq 0 ]; then
    IP=$(sudo docker inspect -f {{.NetworkSettings.IPAddress}} jenkins_identidock_1)
    CODE=$(cutl -sL -w "%{http_code}" $IP:9090/monster/bla -o /dev/null) || true
    if [ $CODE -ne 200 ]; then
        echo "Site returned " $CODE
        ERR=1
    fi
fi

# Останавливаем и чистим контейнеры
sudo docker-compose $COMPOSE_ARGS stop
sudo docker-compose $COMPOSE_ARGS rm --force -v

return $ERR
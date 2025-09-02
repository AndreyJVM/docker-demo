### Данные
1. `Dockerfile` - описание нашего образа для jenkins
2. `jenkins_command.sh` - скрипт для запуска нашего проекта с GitHub в контейнерах (внутри jenkins)
3. `plugins.txt` - плагины для jenkins

---

### Создаём образ контейнера
```shell
docker build -t identijenk .
```

### Запуск контейнера данных
```shell
docker run \
    --name jenkins-data \
    identijenk:latest \
    echo "Jenkins Data Container"
```

### Запуск Jenkins с docker 
```shell
docker run -d \
    --name jenkins \
    -p 8080:8080 \
    --volumes-from jenkins-data \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --group-add $(stat -c '%g' /var/run/docker.sock) \
    identijenk:latest
```
---
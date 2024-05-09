![docker.png](resources/img/docker.png)
---
### Вывод информации о клиете и сервере Docker
```shell
docker version
```
---

### Вывод информации о запущенных и остановленных контейнерах
```shell
docker ps -a
```

---
### Вывод списка локальных образов
```shell
docker images
```
---
### Создание контейнера
```shell
docker run <container_name>
```
---
### Удаление контейнера
```shell
docker rm <container_name or container_id>
```
---
### Переход в интерактивный режим контейнера
```shell
docker run -it <container_name>
```
### Удаление остановленных контейнеров
```shell
docker container prune
```
---
### Запуск контенера в фоновом режиме 
```shell
docker run -d <container_name>
```
---
### Получение информации о контенере
```shell
docker container inspect <container_name or container_id>
```
---
### Остановка контенера
```shell
docker stop <container_name or container_id>
docker kill <container_name or container_id>
```
---
### Подключение к запущенному контенеру
```shell
docker exec -it <container_name or container_id> bash
```
---
### Присвоить контейнеру уникальное имя
```shell
docker run -d --name <cast_name> <container_name>
```
---
### Меппинг портов
```shell
docker run -p <external_port>:<container_port> <container_name>
docker run -p 8080:80 nginx
```
---
### Меппинг томов
```shell
docker run -v <local_path>:<container_path> <container_name>
docker run -v ${PWD}:/ussr/share/nginx/html -p 8080:80 -d nginx
```
---
### Автоматическое удаление остановелнных контейнеров
```shell
docker run --rm <container_name>
```
---

![docker.png](resources/img/docker.png)
---
### Выводим информацию и клиете и сервере Docker
```shell
docker version
```
---

### Выводим информацию о запущенных и остановленных контейнерах
```shell
docker ps -a
```

---
### Выводим список локальных образов
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

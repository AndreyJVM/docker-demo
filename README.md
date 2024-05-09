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

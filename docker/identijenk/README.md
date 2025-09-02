
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

### 
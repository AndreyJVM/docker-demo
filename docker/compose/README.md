## Простой пример взаимодействия нескольких сервисов, при помощи Docker compose

Используется файл main.py который обращается к MongoDB,
выполняет команду listDatabases, и печатаем их в консоль

---
### Запуск docker-compose.yml
```shell
docker-compose up
```
---
### Запуск docker-compose.yml в фоновом режиме
```shell
docker-compose up -d
```
---
### Остановить и удалить все контейнеры docker compose
```shell
docker-compose down
```
---
### Билд при внесении изменений в проект
```shell
docker-compose up -d --build
```
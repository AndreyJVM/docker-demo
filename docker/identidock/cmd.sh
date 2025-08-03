#!/bin/bash

# Если значение переменной ENV равно DEV,
# то запускается web-сервер для отладки,
# в противном случае запускается север для эксплуатации

set -e

if [ "$ENV" = 'DEV' ]; then
    echo "Running development server"
    exec python "identidock.py"
else
    echo "Running Production server"
    exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py \
               --callable app --stats 0.0.0.0:9191
fi
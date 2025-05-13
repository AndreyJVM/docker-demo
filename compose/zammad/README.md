### **Полная инструкция: Перенос Zammad (Docker Compose) на новый сервер без потери данных**

Этот гайд поможет **полностью перенести Zammad с одного сервера на другой**, включая:  
✔ **Контейнеры** (без повторной загрузки образов)  
✔ **Данные** (PostgreSQL, Redis, Elasticsearch, файлы Zammad)  
✔ **Конфигурацию** (`docker-compose.yml`, переменные `.env`)

---

## **🔹 1. Подготовка старого сервера**
### **1.1. Остановка сервисов**
```bash
docker-compose down
```

### **1.2. Сохранение Docker-образов в архив**
*(Чтобы не скачивать их заново с интернета)*
```bash
docker save $(docker-compose config | awk '{if ($1 == "image:") print $2}') -o zammad-images.tar
```

### **1.3. Архивирование данных (томов Docker)**
```bash
# Архивируем каждый том
docker run --rm -v postgresql-data:/source -v $(pwd):/backup alpine tar -czvf /backup/postgresql-data.tar.gz -C /source .
docker run --rm -v redis-data:/source -v $(pwd):/backup alpine tar -czvf /backup/redis-data.tar.gz -C /source .
docker run --rm -v elasticsearch-data:/source -v $(pwd):/backup alpine tar -czvf /backup/elasticsearch-data.tar.gz -C /source .
docker run --rm -v zammad-storage:/source -v $(pwd):/backup alpine tar -czvf /backup/zammad-storage.tar.gz -C /source .
docker run --rm -v zammad-backup:/source -v $(pwd):/backup alpine tar -czvf /backup/zammad-backup.tar.gz -C /source .
```

### **1.4. Копирование файлов на новый сервер**
```bash
scp docker-compose.yml zammad-images.tar* postgresql-data.tar.gz redis-data.tar.gz elasticsearch-data.tar.gz zammad-storage.tar.gz zammad-backup.tar.gz user@new-server:/path/to/zammad/
```

---

## **🔹 2. Настройка нового сервера**

### **2.1. Загрузка Docker-образов**
```bash
cd /path/to/zammad
docker load -i zammad-images.tar  # или gunzip zammad-images.tar.gz && docker load -i zammad-images.tar
```

### **2.2. Восстановление данных**
```bash
# Создаем тома (если их нет)
docker volume create postgresql-data
docker volume create redis-data
docker volume create elasticsearch-data
docker volume create zammad-storage
docker volume create zammad-backup

# Распаковываем данные
docker run --rm -v postgresql-data:/target -v $(pwd):/backup alpine sh -c "tar -xzvf /backup/postgresql-data.tar.gz -C /target"
docker run --rm -v redis-data:/target -v $(pwd):/backup alpine sh -c "tar -xzvf /backup/redis-data.tar.gz -C /target"
docker run --rm -v elasticsearch-data:/target -v $(pwd):/backup alpine sh -c "tar -xzvf /backup/elasticsearch-data.tar.gz -C /target"
docker run --rm -v zammad-storage:/target -v $(pwd):/backup alpine sh -c "tar -xzvf /backup/zammad-storage.tar.gz -C /target"
docker run --rm -v zammad-backup:/target -v $(pwd):/backup alpine sh -c "tar -xzvf /backup/zammad-backup.tar.gz -C /target"
```

### **2.3. Запуск Zammad**
```bash
docker-compose up -d
```

---

## **🔹 Итог**
✅ **Zammad полностью перенесен на новый сервер**  
✅ **Все данные сохранены (PostgreSQL, Redis, Elasticsearch, файлы)**  
✅ **Образы загружены локально (без скачивания из интернета)**  
✅ **Конфигурация осталась прежней**

Теперь можно выключать старый сервер. 🎉
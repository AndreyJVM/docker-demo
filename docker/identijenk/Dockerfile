FROM jenkins/jenkins:latest
USER root

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg

# Создание директории для ключей
RUN install -m 0755 -d /etc/apt/keyrings

# Добавление ключа Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

# Добавление репозитория Docker для Debian
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Установка Docker
RUN apt-get update && apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

# Добавляем пользователя jenkins в группу docker
RUN usermod -aG docker jenkins
RUN newgrp docker

# Альтернативно: меняем группу docker.sock на существующую группу jenkins
RUN chown :jenkins /var/run/docker.sock && \
    chmod 660 /var/run/docker.sock

# Установка плагинов Jenkins
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/plugins.txt
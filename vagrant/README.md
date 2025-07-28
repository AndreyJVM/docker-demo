### Первоначальная настройка Vagrant
1. **Установка VBox**
```shell
    sudo apt install virtualbox
```

2. **Установка Vagrant**
```shell
    unzip unzip vagrant_2.4.7_linux_amd64.zip
```

```shell
    sudo install vagrant /usr/local/bin
```

3. **Работа с Vagrant**
```shell
    vagrant init ubuntu/focal64  # Инициализация нового проекта
    vagrant up                   # Запуск виртуальной машины
```
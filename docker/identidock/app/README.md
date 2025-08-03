```shell
    docker build -t identidock .
```

```shell
    docker run -d -p 5000:5000 identidock:latest
```

```shell
    curl localhost:5000
    # Hello, World!
```

```shell
    docker run -d -p 5000:5000 -v "$(pwd)"/app:/app identidock
```
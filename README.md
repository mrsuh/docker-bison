# Docker Bison

Bison is a general-purpose GLR/LALR parser generator
[https://www.gnu.org/software/bison](https://www.gnu.org/software/bison)

This is the Git repo of the [Docker image for Bison](https://hub.docker.com/repository/docker/mrsuh/bison).

## How to use image

### Get Bison version
```bash
docker run -it --rm mrsuh/bison bison --version
```

### Generate parser from `parser.y` file
```bash
docker run -it --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp mrsuh/bison bison -o parser.java parser.y
```

# play-security

http://localhost:3000/

## Install Framework
### Windows
Buffalo can be installed using the [Scoop](https://scoop.sh/) package manager:
```
C:\> scoop install buffalo
C:\> scoop install gcc
```

### Homebrew (macOS)
Buffalo can be installed using the [Homebrew](https://brew.sh/) package manager:
```
$ brew install gobuffalo/tap/buffalo
```

## Database settings

### Start Postgres
```
$ docker-compose up -d
```

### Install Pop 
Windows:
```
C:\> go install github.com/gobuffalo/pop/v6/soda@latest
```

Homebrew (macOS):
```
$ brew install gobuffalo/tap/pop
```

### Create databases

```
$ buffalo pop create -a
```

### How to access the local database 

```
$ docker exec -it play-security-database bin/bash

Container...
$ psql -U postgres

List of databases...
postgres=# \l
```

## Create Application
### Project

```
$ buffalo new play-security --module github.com/aiit2022-pbl-okuhara/play-security --db-type postgres
```

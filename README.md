# docker-postgresql-client

This project create a Posgresql client on a docker container.
The container is based on [docker-postgresql-base](https://github.com/fferriere/docker-postgresql-base) image.

## Build

To build container run `build.sh` script. You can customize image's name with `FFERRIERE_PG_CLIENT_IMAGE` variable. Example :
```
$ FFERRIERE_PG_CLIENT_IMAGE="prefix/postgresql-client" ./build.sh
```

## Run

To run container execute `psql.sh` script.

Example :
```
$ ./psql.sh
```

If you have customized image :
```
$ FFERRIERE_PG_CLIENT_IMAGE="prefix/postgresql-client" ./psql.sh
```

## Postgres run

You should be connected on server to create user and by default postgres can connect with external host.
The `psql-postgres.sh` script use the `/var/run/postgresql` volume from server container to use socket `.s.PGSQL.5432`.

You can inform on which server client must use with `FFERRIERE_PG_SERVER_NAME` variable. Example :
```
$ FFERRIERE_PG_SERVER_NAME='prefx-postgresql-server' ./psql-postgres.sh
```

## Run with stdin

If you want to call client with stdin query its possible like that :
```
$ ./psql.sh < ~/file.sql
or
$ cat ~/file.sql | ./psql.sql
```

or with socket and postgres user :
```
$ ./psql-postgres.sql < ~/file.sql
or
$ echo "CREATE USER user WITH SUPERUSER PASSWORD 'password'" | ./psql-postgres.sql
```

## Dump

You can call a dump creation with `pg_dump.sh`.

```
$ ./pg_dump.sh -h db.lan -U user -d dbname -W
Password:
```

## Docker arguments

You might want to add a docker arguments for change user or bind a file|directory.

You can use the `FFERRIERE_PG_CLIENT_DOCKER_ARGS` variable to add options at docker run.

`FFERRIERE_PG_CLIENT_DOCKER_ARGS` is usable on `psql.sh` and `pg_dump.sh` scipts.

Exemple, automate dump :
```
$ cat dump.sh
#!/bin/bash

host='db.lan'
port='5432'
database='dbname'
username='user'
password='secret'

tmpfile="my_path/.tmp.pgpass"

echo "$host:$port:$database:$username:$password" > $tmpfile
chmod 400 $tmpfile
FFERRIERE_PG_CLIENT_DOCKER_ARGS="-u user -v $tmpfile:/home/user/.pgpass" \
    FFERRIERE_PG_SERVER_NAME="prefix-pg-server" \
    ./pg_dump.sh -h $host --port $port -U $username -d $database \
    --format tar --blobs --inserts --verbose | gzip > ~/backup.tar.gz
rm -f $tmpfile
```

With this script we can write a `.pgpass` file for save password
and permit to dump a database secure by password without interactive step.

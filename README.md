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

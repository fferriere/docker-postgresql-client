FROM fferriere/postgresql-base

MAINTAINER ferriere.florian@gmail.com

RUN apt-get install -y postgresql-client-9.4

USER user

RUN echo "#!/bin/bash\npg_dump $@ 2> /home/user/pg_dump.log" > /home/user/pg_dump; \
    chmod 755 /home/user/pg_dump

EXPOSE 5432

CMD [ "psql" ]

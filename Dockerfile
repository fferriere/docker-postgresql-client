FROM fferriere/postgresql-base

MAINTAINER ferriere.florian@gmail.com

RUN apt-get install -y postgresql-client-9.4

USER postgres

EXPOSE 5432

CMD [ "psql" ]

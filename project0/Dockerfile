FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt install -y  postgresql postgresql-contrib libpq-dev
RUN apt install -y python3-pip python3-dev
RUN apt install -y jupyter-notebook 
RUN apt install -y build-essential vim 
RUN apt install -y sudo curl systemctl
RUN pip3 install jupyter ipython-sql psycopg2

ADD *.sql /home/project0/
ADD *.ipynb /home/project0/
ADD relationalalgebrafunctions.py /home/project0/
ADD joins.jpg /home/project0/
ADD university.png /home/project0

EXPOSE 8888
EXPOSE 5432

USER postgres

RUN echo "listen_addresses = '*'" >> /etc/postgresql/14/main/postgresql.conf &&\
    echo "host    all             all             0.0.0.0/0               scram-sha-256" >> /etc/postgresql/14/main/pg_hba.conf

RUN /etc/init.d/postgresql start &&\
    createdb university &&\
    psql --command "\i /home/project0/DDL.sql;" university &&\
    psql --command "\i /home/project0/smallRelationsInsertFile.sql;" university &&\
    psql --command "alter user postgres with password 'postgres';" university &&\
    psql --command "create user root;" university &&\
    psql --command "alter user root with password 'root';" university &&\
    psql --command "alter user root with superuser;"

USER root

WORKDIR /home/project0
ENTRYPOINT service postgresql start && /bin/bash

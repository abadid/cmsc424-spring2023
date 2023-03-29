FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get -y upgrade
RUN apt-get -y update
RUN apt-get install -y build-essential default-jdk curl gzip


RUN apt update
RUN apt install -y gpg gnupg2 software-properties-common apt-transport-https lsb-release ca-certificates
RUN curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/postgresql.gpg
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" | tee  /etc/apt/sources.list.d/pgdg.list
RUN apt update
RUN apt install -y postgresql-13 postgresql-client-13


RUN echo "listen_addresses = '*'" >> /etc/postgresql/13/main/postgresql.conf &&\
    echo "password_encryption = md5" >> /etc/postgresql/13/main/postgresql.conf &&\
    echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/13/main/pg_hba.conf

USER postgres

RUN /etc/init.d/postgresql start &&\
    createdb matchapp &&\
    psql --command "create user root;" matchapp &&\
    psql --command "alter user root with password 'root';" matchapp &&\
    psql --command "alter user root with superuser;" matchapp &&\
    psql --command "CREATE USER matchmaker WITH password 'kingofthenorth';"  matchapp &&\
    psql --command "GRANT ALL privileges on database matchapp to matchmaker;" matchapp &&\
    psql --command "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO matchmaker;" matchapp &&\
    psql --command "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO matchmaker;" matchapp 

USER root 
RUN mkdir /opt/tomcat/
WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.87/bin/apache-tomcat-8.5.87.tar.gz
RUN tar xvfz apache-tomcat-8.5.87.tar.gz 
RUN mv apache-tomcat-8.5.87/* /opt/tomcat/.

WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SampleWebApp.war

EXPOSE 8080

COPY ./matchapp /home/project3/matchapp
ADD students.sql /home/project3/
WORKDIR /home/project3/matchapp
RUN chmod +x build.sh

WORKDIR /home/project3/
ENTRYPOINT service postgresql start && /bin/bash
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get install -y postgresql postgresql-contrib build-essential default-jdk curl gzip

USER postgres

RUN /etc/init.d/postgresql start &&\
    createdb matchapp &&\
    psql --command "create user root;" matchapp &&\
    psql --command "alter user root with password 'root';" matchapp &&\
    psql --command "alter user root with superuser;" 

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
ADD organs.sql /home/project3/
WORKDIR /home/project3/matchapp
RUN chmod +x build.sh
ENTRYPOINT service postgresql start && /bin/bash
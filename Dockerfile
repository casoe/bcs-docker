FROM tomcat:8.5-jdk8

# Environment variables are defaults and should be overwritten on docker-run!
ENV JAVA_HOME          /opt/java/openjdk
ENV TOMCAT_HOME        /usr/local/tomcat
ENV BCS                /opt/projektron/bcs/server
ENV PROJEKTRON_VERSION projektron-bcs-21.3.24

# Install packages
RUN apt-get update && apt-get install -y net-tools

# Set workdir to BCS directory
WORKDIR $BCS

# Copy files to root folder
ADD  install/server.tar.gz  $BCS/

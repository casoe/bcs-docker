FROM tomcat:8.5-jdk8

# Environment variables are defaults and should be overwritten on docker-run!

ENV JAVA_HOME /usr/local/openjdk-8
ENV TOMCAT_HOME /usr/local/tomcat
ENV BCS /opt/projektron/bcs
ENV PROJEKTRON_VERSION projektron-bcs-21.3.24

# Install netstat

RUN apt-get update && apt-get install -y \
	net-tools

# Copy scripts to root folder
COPY tools/ /var/

# Set wirkdir to BCS directory
WORKDIR $BCS

# Prepare script to download bcs-files to BCS directory
RUN chmod +x /var/scripts/*

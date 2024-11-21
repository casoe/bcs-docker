FROM tomcat:9.0-jdk17

# Environment variables are defaults and should be overwritten on docker-run!
ENV JAVA_HOME          /opt/java/openjdk
ENV TOMCAT_HOME        /usr/local/tomcat
ENV BCS                /opt/projektron/bcs/server
ENV PROJEKTRON_VERSION projektron-bcs-24.1.27

# Extend path
ENV PATH="${PATH}:/opt/projektron/bcs/server/bin:/opt/projektron/bcs/server/inform_scripts"

# Install packages
RUN apt-get update && apt-get install -y net-tools gettext

# Set workdir to BCS directory
WORKDIR $BCS

# Copy files to root folder
ADD  install/server.tar.gz  $BCS/

# Startup the server
#CMD ["ProjektronBCS.sh", "start"]
CMD ["catalina.sh", "run"]

#!/bin/bash

## Volumes you need to define:
# /scripts                        (e.g. -v docker/bcs/scripts:/scripts)
# /usr/local/tomcat/conf          (e.g. -v /docker/bcs/tomcat/conf:/usr/local/tomcat/conf)
# /opt/projektron/bcs/conf        (e.g. -v /docker/bcs/opt/projektron/bcs/conf:/opt/projektron/bcs/conf)
# /opt/projektron/bcs/customlibs  (e.g. -v /docker/bcs/customlibs:/opt/projektron/bcs/customlibs)

docker run -d \
  --name=bcs-test \
  --restart=always \
  -v tools/scripts:/scripts \
  -v server/tomcat/conf:/usr/local/tomcat/conf \
  -v server/conf:/opt/projektron/bcs/conf \
  -v server/customlibs:/opt/projektron/bcs/customlibs \
  -p 8080:8080 \
  tomcat:8.5-jdk8

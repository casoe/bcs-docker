# Projektron
Dockerfile for Projektron BCS
- Based on initial work by [higain](https://github.com/higain) quite some years ago
- Tailored to a setup running at INFORM and heavily using files which are maintained in separate repository
- Currently working with version 21.3

This is an ongoing project and mainly done on a private basis in my freetime. Therefore, it is also pushed from time to time to github. It's a kind of relief from my regular job since I enjoy working with git and docker and want to learn more about it.

## Variables you need to pass on docker run
- JAVA_HOME (e.g. /opt/java/openjdk)
- TOMCAT_HOME (e.g. /usr/local/tomcat)
- BCS (e.g. /opt/projektron/bcs/server)
- PROJEKTRON_VERSION (e.g. projektron-bcs-21.3.24)

Check bcs-docker.sh

## Volumes you need to define:
- conf (e.g. -v ~/bcs-docker/repo/conf:/opt/projektron/bcs/server/conf)
- conf_local (e.g. -v ~/bcs-docker/repo/conf_local_docker:/opt/projektron/bcs/server/conf_local)
- log (e.g. -v ~/bcs-docker/log:/opt/projektron/bcs/server/log)
- files (e.g. ~/bcs-docker/data/files:/opt/projektron/bcs/server/data/files)
- ftindex (e.g. ~/bcs-docker/data/ftindex:/opt/projektron/bcs/server/data/FTIndex)
- tomcat/conf (e.g. ~/bcs-docker/repo/tomcat/conf85_docker:/usr/local/tomcat/conf)

## Updates:
Updating projektron works by upgrading the container, still ALWAYS backup before changing the $PROJEKTRON_VERSION number.
Minor updates work flawlessly by upgrading the container with the new $PROJEKTRON_VERSION number.
Major updates often require database migration. Do NOT skip major versions, iterate through all aviable versions to correctly migrate your database.

Proposed procedure:
- Backup persisted volumes
- Backup database
- Upgrade container with new major $PROJEKTRON_VERSION variable
- See what happens, read log files (This might take some minutes)

If you encounter any errors, please consult the projektron install guidelines
- If additional database migration is needed, ssh into the container and execute the migration according to the specific releasenotes
- When in doubt, restart the container

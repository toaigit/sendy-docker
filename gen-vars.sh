#!/bin/bash
source vars.env
export DOCKER_ID=`grep $DOCKER_USER /etc/passwd | awk -F':' '{print $3}'`
cat files/templates/ports.templ | gomplate > files/apache/ports.conf
cat files/templates/000-default.templ | gomplate > files/apache/000-default.conf
cat files/templates/default-ssl.templ | gomplate > files/apache/default-ssl.conf
cat files/templates/shibboleth2.templ | gomplate > files/shibb/shibboleth2.xml
cat files/templates/build.templ | gomplate > build.sh
cat files/templates/run.templ | gomplate > run.sh
cat files/templates/run-debug.templ | gomplate > run-debug.sh
cat files/templates/stop.templ | gomplate > stop.sh
cat files/templates/rm.templ | gomplate > rm.sh
cat files/templates/connect.templ | gomplate > connect.sh
cat files/templates/dbinit.templ | gomplate > dbinit.sh
cat files/templates/docker-compose.templ | gomplate > docker-compose.yml

chmod 750 build.sh run.sh stop.sh rm.sh connect.sh run-debug.sh dbinit.sh

cat files/templates/sp-metadata.templ | gomplate > /tmp/sp-metadata.xml
head -n 10 /tmp/sp-metadata.xml > /tmp/head.txt
tail -n +11 /tmp/sp-metadata.xml > /tmp/tail.txt
grep -v CERTIFICATE $WEB_CERT/sp-cert.pem > /tmp/sp-cert.pem
cat /tmp/head.txt /tmp/sp-cert.pem /tmp/tail.txt > files/shibb/sp-metadata.xml


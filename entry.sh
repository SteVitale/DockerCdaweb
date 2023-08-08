#!/bin/bash

#AVVIO SERVIZI MYSQL, APACHE2, TOMCAT E FILE BATCH
service mysql start
service ssh start

cd cdapwinst
sh cdapwinst.sh
cd ..

service apache2 start
service tomcat start

#SOSTITUZIONE FILE INDEX.HTML MODIFICATO (localost:8081)
mv -f index.html /var/www/html/cdaplus/index.html




cd /opt/cdapweb/apache-tomcat-5.5.25/webapps/cdapadmin/
chown -h cdapw:cdapw common
cd
cd ..

cd cdapwinst_update

java -jar cdapwinst.jar update

ln -s /opt/cdapweb/apache-tomcat-5.5.25/shared/lib/common /opt/cdapweb/apache-tomcat-5.5.25/webapps/cdapadmin/common
ln -s /opt/cdapweb/apache-tomcat-5.5.25/shared/lib/common /opt/cdapweb/apache-tomcat-5.5.25/webapps/cdapweb

echo "Tutti i servizi sono stati avviati"

#CICLO PER TENERE VIVO IL CONTAINER
while true; do
   sleep 1
done


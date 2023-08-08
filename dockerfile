FROM ubuntu:18.04

#PACCHETTI VARI
RUN apt-get update
RUN apt-get install -y wget nano apt-utils mysql-server-5.7 openssh-client openssh-server apache2 vim

#FILE CONFIGURAZIONE MYSQL
COPY my.cnf /etc/mysql/
COPY mysql.conf /etc/mysql/mysql.conf.d/


#FILE CON MODIFICHE INDIRIZZI IP E PORTE
COPY /File/index.html /index.html
COPY /File/strConf.props /opt/cdapweb/apache-tomcat-5.5.25/webapps/cdapweb/WEB-INF/
COPY /File/mysqld.cnf /etc/mysql/mysql.conf.d/


#FILE CON COMANDI DA ESEGUIRE ALL'AVVIO DEL CONTAINER
COPY entry.sh /script/entry.sh


#ARCHIVI CDAPWEB
COPY cdapwinst.tar.gz /cdapwinst.tar.gz
COPY cdapwinst_update.tar.gz /cdapwinst_update.tar.gz


#VARIABILE D'AMBIENTE PER FAR FUNZIONARE COMANDO JAVA
ENV PATH "$PATH:/opt/cdapweb/jdk1.5.0_14/bin"


#ESTRAZIONE TAR.GZ
RUN tar xvf cdapwinst.tar.gz
RUN tar xvf cdapwinst_update.tar.gz

#ESPOSIZIONE PORTE
EXPOSE 80 8080 3306 22

#PERMESSI FILE ENTRY.sh
RUN chmod +x /script/entry.sh



##
## Docker container for blockanalytics test stage
##
FROM ubuntu:14.04

MAINTAINER asamuylik@remedypointsolutions.com

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y 		\
	git 					\
	vim						\
	curl 					\
	apache2 				\
	php5 					\
	libapache2-mod-php5 	\
	php5-mcrypt 			\
	php5-mysql 

# Install app
RUN rm -rf /srv/www/*

# Configure apache
RUN a2enmod rewrite
RUN chown -R www-data:www-data /var/www
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf
RUN sudo a2enconf fqdn

ADD https://raw.githubusercontent.com/asamuylikrps/docker-opswork-deploy/master/templates/vhosts/minnesotaunited.conf /data/vhosts/
ADD https://raw.githubusercontent.com/asamuylikrps/docker-opswork-deploy/master/scripts/setup.sh /scripts/

RUN chmod +x /scripts/setup.sh

EXPOSE 80

CMD ["/scripts/setup.sh"]
#CMD ["/usr/bin/source", "/etc/apache2/envvars"]
#CMD ["/usr/sbin/apache2", "-D",  "FOREGROUND"]

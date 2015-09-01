##
## Docker container for blockanalytics test stage
##
FROM ubuntu:14.04

MAINTAINER asamuylik@remedypointsolutions.com

RUN apt-get update 
RUN apt-get install -y nginx zip curl
RUN apt-get install -y apache2

RUN echo 'Test message'

EXPOSE 80 443

FROM ubuntu:14.04

# Update Ubuntu and install common packages
RUN apt-get update -y

RUN apt-get install wget -y

RUN apt-get install python-setuptools -y

RUN apt-get install python-dateutil

RUN wget http://sourceforge.net/projects/s3tools/files/s3cmd/1.5.0-rc1/s3cmd-1.5.0-rc1.tar.gz

RUN tar xvfz s3cmd-1.5.0-rc1.tar.gz

RUN cd /s3cmd-1.5.0-rc1 && python setup.py install

ADD files/s3cfg /.s3cfg
ADD files/main.sh /main.sh

# Main entrypoint script
RUN chmod 777 main.sh

# Folders for s3cmd optionations
RUN mkdir /opt/src
RUN mkdir /opt/dest

WORKDIR /
CMD ["/main.sh"]

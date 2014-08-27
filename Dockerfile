FROM ubuntu:14.04

# Update Ubuntu and install common packages
RUN apt-get update -y
RUN apt-get install -y s3cmd

ADD files/s3cfg /.s3cfg
ADD files/main.sh /main.sh

# Main entrypoint script
RUN chmod 777 main.sh

# Folders for s3cmd optionations
RUN mkdir /opt/src
RUN mkdir /opt/dest

WORKDIR /
CMD ["/main.sh"]
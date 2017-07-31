FROM debian
RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get install -y build-essential python-dev python-pip curl
RUN pip install locustio
COPY entrypoint.sh /

#Web interface
EXPOSE 8080

#Master ports
EXPOSE 5557
EXPOSE 5558

ENTRYPOINT /entrypoint.sh

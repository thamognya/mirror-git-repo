FROM ubuntu:latest
RUN apt install -y git openssh-client
ADD *.sh /
ENTRYPOINT ["/entrypoint.sh"]

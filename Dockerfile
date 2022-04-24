FROM ubuntu:latest
RUN apt -y update && apt -y upgrade && apt install -y git openssh-client
ADD *.sh /
ENTRYPOINT ["/entrypoint.sh"]

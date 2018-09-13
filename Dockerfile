FROM ubuntu:latest
MAINTAINER Manlio García "manliojoaquin@gmail.com"
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential
COPY . /app
COPY default_cmd.sh /
WORKDIR /mnt
ENTRYPOINT ["bash"]
CMD ["/default_cmd.sh"]

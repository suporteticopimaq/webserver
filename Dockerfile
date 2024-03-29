FROM ubuntu:22.04
RUN apt-get update && apt-get install -y \
  apache2 \
  python3 \
  default-jre \
  openssh-server \
  nano \
  && rm -rf /var/lib/apt/lists/*
COPY ./app /app
COPY ./run.sh /run.sh
RUN chmod 755 /run.sh
RUN cp -r /app/* /etc/ssh/
ENV ROOT_PASSWORD=
EXPOSE 80
EXPOSE 22
ENTRYPOINT bash /run.sh

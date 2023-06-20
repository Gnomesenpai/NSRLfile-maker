From debian:stable
ENV DEBIAN_FRONTEND=noninteractive

RUN cd / && mkdir nsrl && cd /nsrl && \
    apt-get update && apt-get install --no-install-recommends --yes wget unzip sqlite3
WORKDIR /
COPY generate.sh /generate.sh
RUN chmod 777 /generate.sh
CMD ["/bin/bash","-c","cd / && /generate.sh"]

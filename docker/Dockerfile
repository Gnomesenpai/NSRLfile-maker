org.opencontainers.image.source = "https://github.com/Gnomesenpai/NSRLfile-maker"
From debian:stable-slim
ENV DEBIAN_FRONTEND=noninteractive

RUN cd / && mkdir nsrl && cd /nsrl && \
    apt-get update && apt-get install --no-install-recommends --yes wget unzip sqlite3
WORKDIR /
COPY generate.sh /generate.sh
COPY sql.sh /sql.sh
RUN chmod 777 /generate.sh && chmod 777 /sql.sh
CMD ["/bin/bash","-c","cd / && /generate.sh"]

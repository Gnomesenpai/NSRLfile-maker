From debian:stable
ENV DEBIAN_FRONTEND=noninteractive

RUN cd / && mkdir nsrl && cd /nsrl && \
    apt-get update && apt-get install --no-install-recommends --yes wget unzip sqlite3

COPY generate.sh /generate.sh
RUN chmod 777 /generate.sh
   #&& \
   # wget https://s3.amazonaws.com/rds.nsrl.nist.gov/RDS/rds_2023.06.1/RDS_2023.06.1_modern_minimal.zip && \
   # unzip

CMD ["/bin/bash","-c","cd /nsrl && /generate.sh"]

# NSRLfile-maker
[![ci](https://github.com/Gnomesenpai/NSRLfile-maker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/Gnomesenpai/NSRLfile-maker/actions/workflows/docker-image.yml)  
Makes NSRLfile.txt from v3 DB
This is only supported for the MODERN PC MINIMAL FULL SQL DOWNLOADS

This is not a fast process and needs a minimum free disk space of 250GB. The unextracted DB is over 150GB alone.

for speed context, a Ubuntu VM on a single Intel Xeon Silver 4310 (4 vcore) took 59minutes
WSL on a dual Intel Xeon Silver 4010 (32 thread) took over 24h, this is a known issue with the way WSL handles the storage layer between the subsystem.


1. clone repo
2. do "chmod 777 depends.sh run.sh"
3. do "sudo depends.sh"
4. do "docker build docker/. -t nsrl:latest OR docker image pull and use the premade package
5. configure storage location in "run.sh"
6. place NSRL DB file into storage location. DB ZIP can be obtained from https://www.nist.gov/itl/ssd/software-quality-group/national-software-reference-library-nsrl/nsrl-download/current-rds
7. sudo run.sh
8. wait...
9. profit!

Github: https://github.com/Gnomesenpai/NSRLfile-maker
Dockerhub: https://hub.docker.com/r/gnomesenpai/nsrlfile-maker

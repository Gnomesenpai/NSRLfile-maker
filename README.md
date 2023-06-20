# NSRLfile-maker
Makes NSRLfile.txt from v3 DB
This is only supported for the MODERN PC MINIMAL FULL SQL DOWNLOADS

This is not a fast process and needs a minimum free disk space of 500GB. The unextracted DB is over 150GB alone.


how to use:
1. Clone repo
2. run "Docker build . -t nsrl:latest"
3. place NSRL DB ZIP file in /home/<user>/nsrl - DB ZIP can be obtained from https://www.nist.gov/itl/ssd/software-quality-group/national-software-reference-library-nsrl/nsrl-download/current-rds
4. docker run -it -v /home/<user>/nsrl:/nsrl nsrl:latest
5. output will be NSRLfile-<date>.txt which can then be ingested into Griffeye, Cellebrite or other forensic software.

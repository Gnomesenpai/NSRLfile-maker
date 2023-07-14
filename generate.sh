RED='\033[0;31m'
NOCOLOUR='\033[0m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
cd /nsrl && \
#rename RDS zip to a standard name
pattern=(RDS*)
#echo $pattern
if [ -f ${pattern[0]} ]; then
mv RDS*.zip nsrl.zip
echo -e "${GREEN}Unzipping archive${NOCOLOUR}"
unzip nsrl.zip
ret=$?
        #corrupt zip failure
        if [ $ret -ne 0 ]; then
        echo -e "${RED}Exit with code $ret - Corrupt ZIP File, please redownload${NOCOLOUR}"
        mv nsrl.zip corrupt.zip
        exit 
        else
rm -v nsrl.zip
cd *minimal
#find DB file attach to a variable to rename
nsrldb="$(ls *minimal.db | sort -V | tail -n1)"
mv -v "$nsrldb" ../backup.db
cd ..
#create TXT from DB file
echo -e "${GREEN}Creating ${YELLOW}output.txt${NOCOLOUR}"
../sql.sh
cd /nsrl
echo -e "${GREEN}sed ${YELLOW}output.txt${NOCOLOUR}"
sed -i 's/"""/"/g' output.txt 
#Create a header file with a single line containing the following, called NSRLFile-header.txt:
echo -e "${GREEN}create ${YELLOW}NSRLFile-header.txt${NOCOLOUR}"
echo "\"SHA-1\",\"MD5\",\"CRC32\",\"FileName\",\"FileSize\",\"ProductCode\",\"OpSystemCode\",\"Speci>
echo -e "${GREEN}cat ${YELLOW}output.txt ${GREEN}into ${YELLOW}NSRLFile-header.txt"
cat output.txt >> NSRLFile-header.txt
echo -e "${RED}Removing output.txt${NOCOLOUR}"
rm -v output.txt
echo -e "${GREEN}sed ${YELLOW}NSRLFile-header.txt${NOCOLOUR}"
echo -e "${GREEN}final file creation${NOCOLOUR}"
sed -e "s/\r//g" NSRLFile-header.txt > NSRLFile-$(date +"%d-%m-%Y").txt
#reclaim space
rm -v NSRLFile-header.txt
rm -v backup.db
rm -R -v RDS*
echo -e "${GREEN}Hashing ${YELLOW}NSRLFile${NOCOLOUR}"
sha1sum NSRLFile-$(date +"%d-%m-%Y").txt > NSRLFile-$(date +"%d-%m-%Y").hash
cat NSRLFile-$(date +"%d-%m-%Y").hash
        fi
else
echo -e "${RED}ERROR!! ${YELLOW}RDS Zip file missing${NOCOLOUR}"
exit 127
fi

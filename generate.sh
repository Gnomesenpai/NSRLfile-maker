cd /nsrl && \
#rename RDS zip to a standard name
mv RDS*.zip nsrl.zip
unzip nsrl.zip
rm nsrl.zip
cd *minimal
#find DB file attach to a variable to rename
nsrldb="$(ls *minimal.db | sort -V | tail -n1)"
mv -v "$nsrldb" ../backup.db
cd ..
#create TXT from DB file
echo "Creating output.txt"
../sql.sh
cd /nsrl
echo "sed output.txt"
sed -i 's/"""/"/g' output.txt 
#Create a header file with a single line containing the following, called NSRLFile-header.txt:
echo "create NSRLFile-header.txt"
echo "\"SHA-1\",\"MD5\",\"CRC32\",\"FileName\",\"FileSize\",\"ProductCode\",\"OpSystemCode\",\"SpecialCode\"" > NSRLFile-header.txt
echo "cat output.txt into NSRLFile-header.txt"
cat output.txt >> NSRLFile-header.txt
echo "sed NSRLFile-header.txt"
echo "final file creation"
sed -e "s/\r//g" NSRLFile-header.txt > NSRLFile-$(date +"%d-%m-%Y").txt
#reclaim space
rm output.txt
rm NSRLFile-header.txt
rm backup.db
rm -R RDS*
echo "Hashing NSRLFile"
sha1sum NSRLFile-$(date +"%d-%m-%Y").txt > NSRLFile-$(date +"%d-%m-%Y").hash
cat NSRLFile-$(date +"%d-%m-%Y").hash

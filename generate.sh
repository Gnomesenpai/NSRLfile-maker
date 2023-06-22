cd /nsrl && \
#mv RDS*.zip nsrl.zip
unzip nsrl.zip
#rm nsrl.zip
cd *minimal
nsrldb="$(ls *minimal.db | sort -V | tail -n1)"
cp -v "$nsrldb" ../backup.db
cd ..
#create TXT from DB file
ls -lah
echo "Creating output.txt"
sqlite3 ./backup.db << 'END_SQL'
DROP TABLE IF EXISTS EXPORT;
CREATE TABLE EXPORT AS SELECT sha1, md5, crc32, file_name, file_size, package_id FROM FILE;
UPDATE EXPORT SET file_name = REPLACE(file_name, '"', '');
#.bail on
.mode csv
.headers off
.output output.txt
SELECT '"' || sha1 || '"', '"' || md5 || '"', '"' || crc32 || '"', '"' || file_name || '"', file_siz>
package_id, '"' || 0 || '"', '"' || '"' FROM EXPORT ORDER BY sha1;
#.crashsqlite3
#.exit
echo "sed output.txt"
sed -i "s/"""/"/g" output.txt
#Create a header file with a single line containing the following, called NSRLFile-header.txt:
echo "create NSRLFile-header.txt"
echo "\"SHA-1\",\"MD5\",\"CRC32\",\"FileName\",\"FileSize\",\"ProductCode\",\"OpSystemCode\",\"Speci>
ls -lah
echo "cat output.txt into NSRLFile-header.txt"
cat output.txt >> NSRLFile-header.txt
ls -lah
echo "sed NSRLFile-header.txt"
sed -i 's/"""/"/g' NSRLFile-header.txt
echo "final file creation"
sed -e "s/\r//g" NSRLFile-header.txt > NSRLFile-$(date +"%d-%m-%Y").txt
#reclaim space
#rm output.txt
#rm NSRLFile-header.txt

cd /media/user/nsrl/ && \
#wget http://172.25.15.117/RDS_2023.06.1_modern_minimal.zip -O  nsrl.zip && \
#unzip nsrl.zip
rm nsrl.zip
cd *minimal
#nsrldb="$(ls *minimal.db | sort -V | tail -n1)"
#mv -v "$nsrldb" ../backup.db
cd ..
#create TXT from DB file
ls -lah
sqlite3 ./backup.db <<'END_SQL'
DROP TABLE IF EXISTS EXPORT;
CREATE TABLE EXPORT AS SELECT sha1, md5, crc32, file_name, file_size, package_id FROM FILE;
UPDATE EXPORT SET file_name = REPLACE(file_name, '"', '');
.mode csv
.headers off
.output output.txt
SELECT '"' || sha1 || '"', '"' || md5 || '"', '"' || crc32 || '"', '"' || file_name || '"', file_size, 
package_id, '"' || 0 || '"', '"' || '"' FROM EXPORT ORDER BY sha1;
.q
sed -i 's/"""/"/g' output.txt
#Create a header file with a single line containing the following, called NSRLFile-header.txt:
echo "SHA-1","MD5","CRC32","FileName","FileSize","ProductCode","OpSystemCode","SpecialCode" > NSRLFile-header.txt
cat output.txt >> NSRLFile-header.txt
sed -e "s/\r//g" NSRLFile-header.txt > NSRLFile-$(date +"%d-%m-%Y").txt
#reclaim space
rm output.txt NSRLFile-header.txt
#reclaim DB space/name
DROP TABLE IF EXISTS EXPORT;

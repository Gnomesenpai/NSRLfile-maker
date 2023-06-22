cd /nsrl
sqlite3 -batch ./backup.db << 'END_SQL'
DROP TABLE IF EXISTS EXPORT;
CREATE TABLE EXPORT AS SELECT sha1, md5, crc32, file_name, file_size, package_id FROM FILE;
UPDATE EXPORT SET file_name = REPLACE(file_name, '"', '');
.bail on
.mode csv
.headers off
.output output.txt
SELECT '"' || sha1 || '"', '"' || md5 || '"', '"' || crc32 || '"', '"' || file_name || '"', file_size,
package_id, '"' || 0 || '"', '"' || '"' FROM EXPORT ORDER BY sha1;
.quit

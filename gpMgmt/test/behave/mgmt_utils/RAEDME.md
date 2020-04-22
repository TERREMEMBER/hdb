### Command tools hdbrestore's Usage
Steps:
##### 1. prepare test database
createdb mytest
psql mytest -c "create table t1(a int);"
##### 2. execute command hdbbackup
hdbbackup --backup-dir /tmp/mybak --dbname mytest
details:
backup-dir: Copies all required backup files (metadata files and data files) to the specified directory.
dbname: Specifies the database to back up.
##### 3. clean up environment
dropdb mytest
##### 4. execute command hdbrestore
eg. hdbrestore --backup-dir /tmp/mybak --timestamp 20200420092835 --create-db
details:
backup-dir: Sources all backup files (metadata files and data files) from the specified directory.
timestamp: Specifies the timestamp of the hdbbackup backup set to restore.
create-db  Creates the database before restoring the database object metadata.

#### The following test case will run failed unless copy specified data to /tmp/hdbrestore/data directory.
test case:
```
Tag@hdbrestore
Feature: hdbrestore behave tests
Scenario: hdbrestore functional test
```
steps:
Copy and unzip data /mnt/vdc1/share/hdbrestore-data.tar.gz from 10.221.129.153 to /tmp/hdbrestore/data on current host.
eg. tar -xvf hdbrestore-data.tar.gz -C /tmp/hdbrestore
behave test 

#!/bin/bash
docker run -d --name firebird  -e ISC_PASSWORD=masterkey -e FIREBIRD_DATABASE=testdb.fdb -e EnableLegacyClientAuth=true -p 3050:3050 jacobalberty/firebird:4.0
docker ps -a
sleep 15

# create Dialect1 database
docker exec firebird echo "SET SQL DIALECT 1;CREATE DATABASE '/firebird/data/testdb_d1.fdb' user 'SYSDBA' password 'masterkey';create or alter user SYSDBA password 'masterkey' using plugin Legacy_UserManager;create or alter user SYSDBA password 'masterkey' using plugin Srp;QUIT;" | /usr/local/firebird/bin/isql

docker exec firebird ls -a /firebird/data
docker exec firebird ls -a /firebird/log
docker exec firebird cat /firebird/log/firebird.log

docker logs firebird


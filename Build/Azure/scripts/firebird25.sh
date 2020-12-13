#!/bin/bash
docker run -d --name firebird -e ISC_PASSWORD=masterkey -e FIREBIRD_DATABASE=testdb.fdb -p 3050:3050 jacobalberty/firebird:2.5-sc
docker ps -a
sleep 5

# create Dialect1 database
docker exec firebird echo SET SQL DIALECT 1;CREATE DATABASE '/firebird/data/testdb_d1.fdb' user 'SYSDBA' password 'masterkey';create or alter user SYSDBA password 'masterkey' using plugin Legacy_UserManager;create or alter user SYSDBA password 'masterkey' using plugin Srp;QUIT; | /usr/local/firebird/bin/isql

docker logs firebird

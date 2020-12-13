#!/bin/bash
docker run -d --name firebird -e ISC_PASSWORD=masterkey -e FIREBIRD_DATABASE=testdb.fdb -p 3050:3050 jacobalberty/firebird:2.5-sc
docker ps -a
sleep 5

# create Dialect1 database
docker exec firebird sh -c "echo SET SQL DIALECT 1;CREATE DATABASE '/firebird/data/testdbd1.fdb' USER 'SYSDBA' PASSWORD 'masterkey' DEFAULT CHARACTER SET UTF8;QUIT; | /usr/local/firebird/bin/isql"

docker logs firebird

#!/bin/bash

docker run -d --name hana2 -p 39013:39013 store/saplabs/hanaexpress:2.00.045.00.20200121.1 --agree-to-sap-license --passwords-url file:///hana/password.json

#echo Generate password file
cat <<-EOJSON > hana_password.json
{"master_password": "Passw0rd"}
EOJSON

docker cp hana_password.json hana2:/hana/password.json
docker exec hana2 sudo chmod 600 /hana/password.json
docker exec hana2 sudo chown 12000:79 /hana/password.json

docker ps -a

retries=0
until docker logs hana2 | grep -q 'Startup finished'; do
    sleep 5
    retries=`expr $retries + 1`
    echo waiting for hana2 to start
    if [ $retries -gt 100 ]; then
        echo hana2 not started or takes too long to start
        exit 1
    fi;
done

docker logs hana2

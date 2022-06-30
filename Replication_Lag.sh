#!/bin/bash


#linkedin : https://www.linkedin.com/in/can-sayın-b332a157/
#cansayin.com

# Database credentials
user="abc"
password="abc"
#port=27017
timestamp=$(date)
server=$(hostname)
>/tmp/lag.txt
SlaveLag=`mongo $server:27017/admin -u $user -p $password --eval 'db.printSlaveReplicationInfo()' | grep 'behind' | awk 'BEGIN { FS = "behind" } { print $1 }' | head -n1 | awk '{print $1}'`
if [ $SlaveLag -gt 100 ]
then
echo "Hi Team,">> /tmp/lag.txt
echo "Replication Lag is $SlaveLag hr(s)" on $server at $timestamp  >> /tmp/lag.txt
mail -s " MongoDB Replication Lag on $server"  -S smtp=smtp://smtp.mailserver.com -S from=alert@yourmail.com  to-recievemail@domain.com  < /tmp/lag.txt
else
echo "Everything is fine"
fi
STEP 3:
To Compile   (if “Everything is fine” appears then the script is running properly)
sh lag.sh

STEP 4:
Setting the cronjob
crontab -e
* * * * * /bin/bash  /data/script/lag.sh

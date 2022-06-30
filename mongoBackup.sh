#!/bin/bash



#linkedin : https://www.linkedin.com/in/can-sayın-b332a157/
#cansayin.com



. /home/mongo/.profile
export MYUSER=`cat /home/mongo/MOBCKUSR`
export MYPASS=`cat /home/mongo/MOBCKPWD`
APP_NAME="Backup_Project"
MONGO_HOST="IP yaz"
MONGO_PORT="27017"
TIMESTAMP=`date +%F-%H%M`
MONGODUMP_PATH=$MONGO_HOME/bin/mongodump
BACKUPS_DIR="/backup/$APP_NAME"
BACKUP_NAME="$APP_NAME-$TIMESTAMP"
$MONGODUMP_PATH --out $BACKUP_NAME -h $MONGO_HOST:$MONGO_PORT --username $MYUSER --password $MYPASS > /dba/scripts/Backup_Project/output.out 2>&1

mkdir -p $BACKUPS_DIR
tar -zcvf $BACKUPS_DIR/$BACKUP_NAME.tgz $BACKUP_NAME
rm -rf $BACKUP_NAME
##Hata kontrolu yapilir##
checklog=`cat /dba/scripts/Backup_Project/output.out | grep  -i "error" | wc -l`
if [ $checklog -eq 1 ]
then
echo "BACKUP ERROR" 
mailx  -s "$HOSTNAME Backup_Project`date +%Y%m%d` DB BACKUP ERROR" -r  "$frommail" -S smtp="$smtpmail" $tomail </dba/scripts/Backup_Project/output.out
else
echo "BACKUP COMPLATED" 
mailx  -s "$HOSTNAME Backup_Project`date +%Y%m%d` DB BACKUP COMPLATE" -r  "$frommail" -S smtp="$smtpmail" $tomail </dba/scripts/Backup_Project/output.out
fi

cd $BACKUPS_DIR
find /backup/$APP_NAME -name \*$APP_NAME*.tgz -mtime +15 -exec rm {} \;
 

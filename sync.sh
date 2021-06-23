#!/bin/bash
# LOCAL VARIABLES
# ПО такому пути у меня расположен сайт собственно
DIR_LOCAL="/home/mixalin/docker/pan-new/src"
#DB_LOCAL_NAME="docker_pan"
#DB_LOCAL_USER="docker_pan"
#DB_LOCAL_PASSWORD='docker_pan'
#
# REMOTE HOST
PORT_HOST=22;
SSH_HOST='pan@92.53.65.173'
SSH_PASS='lDuca1aZoNnh9uNRBiZK'
TMP_HOST='/var/www/pan/test2.panchemodan.ru/upload/backup'
DIR_HOST='/var/www/pan/test2.panchemodan.ru'

DB_USER_HOST='test2'
DB_PASS_HOST='Jujiogu4'
DB_NAME_HOST='test2'
DB_HOST_HOST='localhost'

#echo "Database sync ....\n";
##
sudo ssh -p ${PORT_HOST} ${SSH_HOST} "rm -f ${TMP_HOST}/dump.sql.gz; mysqldump --host=${DB_HOST_HOST} -u ${DB_USER_HOST} -p${DB_PASS_HOST} ${DB_NAME_HOST} > ${TMP_HOST}/dump.sql; gzip ${TMP_HOST}/dump.sql"
scp -P ${PORT_HOST} ${SSH_HOST}:${TMP_HOST}/dump.sql.gz ${DIR_LOCAL}/../
echo "Database sync done....\n";

#
#echo "File sync start\n";
#sudo ssh -p ${PORT_HOST} ${SSH_HOST} "rm -f ${TMP_HOST}/backup.tar.gz; cd ${DIR_HOST}; tar -czf upload/backup/backup.tar.gz --exclude='ftp.panchemodan.ru/*.{jpg,JPG,gif,png,wmv,flv,tar.gz,zip,xml,mp3,wav,log}' --exclude='upload/*.gz' --exclude='upload/*.zip' --exclude='upload/iblock/*' --exclude='upload_copy/*'  --exclude='upload/tmp/*' --exclude='upload/pan.reviews/*' --exclude='upload/resize_cache_bu/*' --exclude='upload/resize_cache/*' --exclude='bitrix/managed_cache/*' --exclude='bitrix/backup/*' --exclude='bitrix/cache/*' ./"
#
#scp -P ${PORT_HOST} ${SSH_HOST}:${TMP_HOST}/backup.tar.gz ${DIR_LOCAL}/
#tar xvzf ${DIR_LOCAL}/backup.tar.gz -C ${DIR_LOCAL}
#
#echo "File sync done....\n";
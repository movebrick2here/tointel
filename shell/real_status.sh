#!/usr/bin/env bash

HOST="127.0.0.1"
PORT=3306
USER="root"
PASSWORD="ecp888888"
DATABASE="db_ecp_v2"
TIMESTAMP=`date +%s`
DATE=`date +%Y-%m-%d`
PLATFORM_ID="1"
PLATFORM_NAME="tointel"

LOG="/data/logs/script/REAL_STATUS_${DATE}.LOG"

function DelDeviceRealStatus() {
  DEVICE_ID=$1

  SQL="delete from t_real_status where device_id=${DEVICE_ID};"

  MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

  VALUES=`$MYSQL -e "$SQL" --skip-column-names`
}

function DoDeviceRealStatus() {
  DEVICE_ID=$1

  SQL="insert into t_real_status (select * from t_status where device_id=${DEVICE_ID} order by status_time desc limit 1)"

  MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

  VALUES=`$MYSQL -e "$SQL" --skip-column-names`  
}

function DoRealStatus() {
    SQL="select device_id from t_terminal;"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][Has no device to doing]" >> $LOG
       return
    fi

    for ITEM in ${VALUES}
    do
        `DelDeviceRealStatus ${ITEM}`
        `DoDeviceRealStatus ${ITEM}`
    done
}

DoRealStatus

#*/1 * * * * /home/tointel/stat/real_status.sh >/dev/null 2>&1
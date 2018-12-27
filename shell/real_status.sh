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

  SQL="insert into t_real_status (select * from t_status where device_id=${DEVICE_ID} order by status_time desc limit 1) ON DUPLICATE KEY UPDATE device_id=${DEVICE_ID};"

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
#        `DelDeviceRealStatus ${ITEM}`
        `DoDeviceRealStatus ${ITEM}`
    done
}

function DoRunningStat() {
    let status_threshold=${TIMESTAMP}-5*60
    SQL="select count(*) as value from v_terminal_real_status where status_time <= ${status_threshold};"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][running online stat error]" >> $LOG
       return
    fi

    ONLINE=${VALUES[0]}

    SQL="select count(*) as value from v_terminal_real_status where status_time > ${status_threshold};"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][running offline stat error]" >> $LOG
       return
    fi

    OFFLINE=${VALUES[0]}

    SQL="select count(*) as value from v_terminal_real_status where running = 2;"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][running close stat error]" >> $LOG
       return
    fi

    CLOSE=${VALUES[0]}

    SQL="select count(*) as value from v_terminal_real_status where running = 1;"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][running running stat error]" >> $LOG
       return
    fi

    RUNNING=${VALUES[0]}

    SQL="update t_running_stat set running=${RUNNING},close=${CLOSE},offline=${OFFLINE},online=${ONLINE},update_time=${TIMESTAMP}"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    echo "[$TIMESTAMP][UPDATE][SQL:$SQL]" >> ${LOG}    
}

DoRealStatus
DoRunningStat

#*/1 * * * * /home/tointel/stat/real_status.sh >/dev/null 2>&1
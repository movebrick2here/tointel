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

LOG="/data/logs/script/STAT_${DATE}.LOG"

function Insert2Stat() {
    DEVICE_ID=$1
    DETAIL=$2
    RUNNING_TIME=$3
    HUMAN_TIME=$4
    DOOR_TIME=$5
    WINDOW_TIME=$6
    TEMP=$7
    HUMIDITY=$8
    CONSUMPTION=$9
    TOTAL_CONSUMPTION=${10}
    DATE_PARAM=${11}

    let RUN_HOUR=${RUNNING_TIME}/60
    let HOUR_CONSUMPTION=0
    if [ $RUN_HOUR != 0 ] ; then
      HOUR_CONSUMPTION=${CONSUMPTION}/${RUN_HOUR}
    fi

    SQL="insert into t_status_stat(device_id,stat,running_time,human_time,door_time,window_time,temp,humidity,consumption,hour_consumption,stat_time,total_consumption,platform_id,platform_name,update_time,create_time) value('$DEVICE_ID','$DETAIL',$RUNNING_TIME,$HUMAN_TIME,$DOOR_TIME,$WINDOW_TIME,$TEMP,$HUMIDITY,$CONSUMPTION,$HOUR_CONSUMPTION,$DATE_PARAM,$TOTAL_CONSUMPTION,'$PLATFORM_ID','$PLATFORM_NAME',$TIMESTAMP,$TIMESTAMP)"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    echo "[$TIMESTAMP][INSERT][SQL:$SQL]" >> ${LOG}
}

function DoStatSeg() {
    SEGMENTS=$1
    IX=$2

    NUM=0

    RUN_MODE=0
    RUNNING=0
    TEMP=0
    WINDOW=0
    HUMAN=0
    DOOR=0
    CONSUMPTION=0
    HUMIDITY=0
    TOTAL_CONSUMPTION=0

    for LINE in $SEGMENTS
    do
        OLD_IFS=$IFS
        IFS=','
        arr=($LINE)
        IFS=$OLD_IFS

        INDEX_NUM=${#arr[@]}
        if [ $INDEX_NUM != 9 ] ; then
           echo "[$TIMESTAMP][ERROR][$LINE INVALID]" >> $LOG
           continue
        fi
        let NUM=${NUM}+1
        let RUN_MODE=${arr[0]}
        let RUNNING=${RUNNING}+${arr[1]}
        let TEMP=${TEMP}+${arr[2]}
        let WINDOW=${WINDOW}+${arr[3]}
        let HUMAN=${HUMAN}+${arr[4]}
        let DOOR=${DOOR}+${arr[5]}
        let CONSUMPTION=${CONSUMPTION}+${arr[6]}
        let HUMIDITY=${HUMIDITY}+${arr[7]}
        let TOTAL_CONSUMPTION=${arr[8]}
    done

    let HALF_NUM=${NUM}/2
    let THRESHOLD=${HALF_NUM}+${HALF_NUM}*2
    if [ "$RUNNING" -lt "$THRESHOLD" ] ; then
        let RUNNING=1
    else
        let RUNNING=2
    fi
    if [ ${WINDOW} -lt ${THRESHOLD} ] ; then
        let WINDOW=1
    else
        let WINDOW=2
    fi
    if [ ${HUMAN} -lt ${THRESHOLD} ] ; then
        let HUMAN=1
    else
        let HUMAN=2
    fi
    if [ ${DOOR} -lt ${THRESHOLD} ] ; then
        let DOOR=1
    else
        let DOOR=2
    fi

    let TEMP=${TEMP}/${NUM}
    let HUMIDITY=${HUMIDITY}/${NUM}

    FLAG_LIST="${RUN_MODE},${RUNNING},${TEMP},${WINDOW},${HUMAN},${DOOR},${HUMIDITY},${CONSUMPTION},${TOTAL_CONSUMPTION}"
    ITEM="{\"rm\":\"${RUN_MODE}\",\"ri\":\"${RUNNING}\",\"tp\":\"${TEMP}\",\"wd\":\"${WINDOW}\",\"hm\":\"${HUMAN}\",\"dr\":\"${DOOR}\",\"hd\":\"${HUMIDITY}\",\"cp\":\"${CONSUMPTION}\",\"ix\":\"${IX}\"}"
    echo "${ITEM} ${FLAG_LIST}"
}

function StatSegment() {
    DEVICE_ID=$1
    STAT_DATE=$2

    TOTAL_RUN_MODE=0
    TOTAL_RUNNING=0
    TEMP=0
    TOTAL_WINDOW=0
    TOTAL_HUMAN=0
    TOTAL_DOOR=0
    HUMIDITY=0
    DAY_TOTAL_CONSUMPTION=0
    TOTAL_CONSUMPTION=0

    DETAIL="["
    for((i=1;i<48;i++));
    do
        let PREV_SEG=${i}-1
        let BEGIN_TIME=${STAT_DATE}+${PREV_SEG}*1800
        let END_TIME=${STAT_DATE}+${i}*1800

        SQL="select concat(run_mode,',',running,',',temp,',',window,',',human,',',door,',',consumption,',',humidity,',',total_consumption) from t_status where device_id=$DEVICE_ID and status_time>$BEGIN_TIME and status_time<$END_TIME order by status_time desc"

        MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

        VALUE=`$MYSQL -e "$SQL" --skip-column-names`

        if [ "$VALUE" == "" ] ; then
           continue
        fi

        ITEM=`DoStatSeg "${VALUE}" "${i}"`

        OLD_IFS=$IFS
        IFS=' '
        ITEM_ARRAY=($ITEM)
        IFS=$OLD_IFS

        DETAIL="${DETAIL}${ITEM_ARRAY[0]}"
        if [ ${i} -eq 47 ] ; then
            DETAIL="${DETAIL}"
        else
            DETAIL="${DETAIL},"
        fi

        TOTAL_TIME=${ITEM_ARRAY[1]}
        OLD_IFS=$IFS
        IFS=','
        TOTAL_ARRAY=($TOTAL_TIME)
        IFS=$OLD_IFS

        let TOTAL_RUN_MODE=${TOTAL_ARRAY[0]}
        if [ ${TOTAL_ARRAY[1]} == 1 ] ; then
            TOTAL_RUNNING=${TOTAL_RUNNING}+30
        fi
        if [ ${TOTAL_ARRAY[3]} == 1 ] ; then
            TOTAL_WINDOW=${TOTAL_WINDOW}+30
        fi
        if [ ${TOTAL_ARRAY[4]} == 1 ] ; then
            TOTAL_HUMAN=${TOTAL_HUMAN}+30
        fi
        if [ ${TOTAL_ARRAY[5]} == 1 ] ; then
            TOTAL_DOOR=${TOTAL_DOOR}+30
        fi
        let TEMP=${TEMP}+${TOTAL_ARRAY[2]}
        let DAY_TOTAL_CONSUMPTION=${DAY_TOTAL_CONSUMPTION}+${TOTAL_ARRAY[7]}
        let HUMIDITY=${HUMIDITY}+${TOTAL_ARRAY[6]}
        let TOTAL_CONSUMPTION=${TOTAL_ARRAY[8]}
    done

    let TEMP=${TEMP}/48
    let HUMIDITY=${HUMIDITY}/48

    DETAIL="${DETAIL}]"

    Insert2Stat ${DEVICE_ID} ${DETAIL} ${TOTAL_RUNNING} ${TOTAL_HUMAN} ${TOTAL_DOOR} ${TOTAL_WINDOW} ${TEMP} ${HUMIDITY} ${DAY_TOTAL_CONSUMPTION} ${TOTAL_CONSUMPTION} ${STAT_DATE}
}

function Delete() {
    DEVICE_ID=$1
    DATE_PARAM=$2

    SQL="delete from t_status where device_id=${DEVICE_ID} and from_unixtime(status_time, '%Y-%m-%d')=from_unixtime(${DATE_PARAM}, '%Y-%m-%d')"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    echo "[$TIMESTAMP][DELETE][SQL:$SQL]" >> ${LOG}
}

function Stat() {
    DATE_PARAM=$1
    SQL="select device_id from t_terminal;"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][Has no device to stat]" >> $LOG
       return
    fi

    for ITEM in ${VALUES}
    do
        `StatSegment ${ITEM} ${DATE_PARAM}`
        Delete ${ITEM} ${DATE_PARAM}
    done
}

PARAMS=$#
if [ $PARAMS != 0 ] && [ $PARAMS != 2 ] ; then
    echo "Usage:[START_DATE(2017-01-01)] [DAYS]"
    exit
fi

if [ $PARAMS == 0 ] ; then
    START_TIMESTAMP=`date -d "${DATE}" +%s`
    let START_TIMESTAMP=${START_TIMESTAMP}-3600*24
    Stat ${START_TIMESTAMP}

    exit
fi

if [ $PARAMS == 2 ] ; then
    echo "[INFO][STAT HISTORY STATUS]" >> $LOG
    START_TIMESTAMP=`date -d "$1" +%s`
    let DAYS=$2*3600*24
    let LAST_TIMESTAMP=${START_TIMESTAMP}+${DAYS}
    echo "${START_TIMESTAMP} ${LAST_TIMESTAMP}"
    for((;${START_TIMESTAMP}<${LAST_TIMESTAMP};));
    do
        let START_TIMESTAMP=${START_TIMESTAMP}+3600*24
        Stat ${START_TIMESTAMP}
    done
    exit
fi

#0 1 * * * /home/tointel/stat/stat.sh >/dev/null 2>&1
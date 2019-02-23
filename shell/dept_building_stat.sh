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

LOG="/data/logs/script/DEPT_BUILDING_STAT_${DATE}.LOG"

function dept_item_mean_stat() {
    DEPT_ID=$1
    DATE_PARAM=$2

    SQL="select sum(running_time) as running_time, sum(human_time) as human_time, sum(window_time) as window_time, sum(door_time) as door_time, sum(total_consumption) as total_consumption from v_terminal_status_stat where dept_id='${DEPT_ID}';"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][dept: ${DEPT_ID} stat error]" >> $LOG
       return
    fi

    ITEM_ARRAY=(0,0,0,0,0)
    i=0
    for ITEM in ${VALUES}
    do
       if [ "$ITEM" == "NULL" ] ; then
          return
       fi
       ITEM_ARRAY["$i"]=$ITEM
       let i++
    done

    SQL="insert into t_dept_mean_stat(dept_id, dept_name, running_time, human_time, window_time, door_time, total_consumption) value('${DEPT_ID}', '', ${ITEM_ARRAY[0]}, ${ITEM_ARRAY[1]}, ${ITEM_ARRAY[2]}, ${ITEM_ARRAY[3]}, ${ITEM_ARRAY[4]})"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    echo "[$TIMESTAMP][UPDATE][SQL:$SQL]" >> ${LOG}      
}

function dept_item_stat() {
    DEPT_ID=$1
    DATE_PARAM=$2

    SQL="select sum(running_time) as running_time, sum(human_time) as human_time, sum(window_time) as window_time, sum(door_time) as door_time, avg(consumption) as consumption, sum(total_consumption) as total_consumption, avg(humidity) as humidity, avg(temp) as temp, avg(hour_consumption) as hour_consumption from v_terminal_status_stat where dept_id='${DEPT_ID}' and from_unixtime(stat_time, '%Y-%m-%d')=from_unixtime(${DATE_PARAM}, '%Y-%m-%d');"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][dept: ${DEPT_ID} stat error]" >> $LOG
       return
    fi

    ITEM_ARRAY=(0,0,0,0,0,0,0,0,0)
    i=0
    for ITEM in ${VALUES}
    do
       if [ "$ITEM" == "NULL" ] ; then
          return
       fi
       ITEM_ARRAY["$i"]=$ITEM
       let i++
    done

    SQL="insert into t_dept_stat(dept_id, dept_name, running_time, human_time, window_time, door_time, consumption, total_consumption, humidity, temp, hour_consumption, stat_time, platform_id, platform_name, update_time, create_time) value('${DEPT_ID}', '', ${ITEM_ARRAY[0]}, ${ITEM_ARRAY[1]}, ${ITEM_ARRAY[2]}, ${ITEM_ARRAY[3]}, ${ITEM_ARRAY[4]}, ${ITEM_ARRAY[5]}, ${ITEM_ARRAY[6]}, ${ITEM_ARRAY[7]}, ${ITEM_ARRAY[8]}, ${DATE_PARAM}, 1, 'tointel', ${DATE_PARAM}, ${DATE_PARAM})"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    echo "[$TIMESTAMP][UPDATE][SQL:$SQL]" >> ${LOG}     
}

function depts_stat() {
    DATE_PARAM=$1
    SQL="select dept_id from t_dept;"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][Has no dept to stat]" >> $LOG
       return
    fi

    for ITEM in ${VALUES}
    do
        `dept_item_stat ${ITEM} ${DATE_PARAM}`
        `dept_item_mean_stat ${ITEM} ${DATE_PARAM}`
    done
}

function building_item_stat() {
    BUILDING_ID=$1
    DATE_PARAM=$2

    SQL="select sum(running_time) as running_time, sum(human_time) as human_time, sum(window_time) as window_time, sum(door_time) as door_time, avg(consumption) as consumption, sum(total_consumption) as total_consumption, avg(humidity) as humidity, avg(temp) as temp, avg(hour_consumption) as hour_consumption from v_terminal_status_stat where building_id='${BUILDING_ID}' and from_unixtime(stat_time, '%Y-%m-%d')=from_unixtime(${DATE_PARAM}, '%Y-%m-%d');"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][dept: ${DEPT_ID} stat error]" >> $LOG
       return
    fi

    ITEM_ARRAY=(0,0,0,0,0,0,0,0,0)
    i=0
    for ITEM in ${VALUES}
    do
       if [ "$ITEM" == "NULL" ] ; then
          return
       fi
       ITEM_ARRAY["$i"]=$ITEM
       let i++
    done

    SQL="insert into t_building_stat(building_id, building_name, running_time, human_time, window_time, door_time, consumption, total_consumption, humidity, temp, hour_consumption, stat_time, platform_id, platform_name, update_time, create_time) value('${BUILDING_ID}', '', ${ITEM_ARRAY[0]}, ${ITEM_ARRAY[1]}, ${ITEM_ARRAY[2]}, ${ITEM_ARRAY[3]}, ${ITEM_ARRAY[4]}, ${ITEM_ARRAY[5]}, ${ITEM_ARRAY[6]}, ${ITEM_ARRAY[7]}, ${ITEM_ARRAY[8]}, ${DATE_PARAM}, 1, 'tointel', ${DATE_PARAM}, ${DATE_PARAM})"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    echo "[$TIMESTAMP][UPDATE][SQL:$SQL]" >> ${LOG}     
}

function buildings_stat() {
    DATE_PARAM=$1
    SQL="select building_id from t_building;"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][Has no building to stat]" >> $LOG
       return
    fi

    for ITEM in ${VALUES}
    do
        `building_item_stat ${ITEM} ${DATE_PARAM}`
    done
}

function building_item_stat_level0() {
    BUILDING_ID=$1

    SQL="select sum(running_time) as running_time, sum(human_time) as human_time, sum(window_time) as window_time, sum(door_time) as door_time, avg(consumption) as consumption, sum(total_consumption) as total_consumption, avg(humidity) as humidity, avg(temp) as temp, avg(hour_consumption) as hour_consumption, building_name from v_terminal_status_stat where building_f_tree  like '${BUILDING_ID}%';"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][dept: ${DEPT_ID} stat error]" >> $LOG
       return
    fi

    ITEM_ARRAY=(0,0,0,0,0,0,0,0,0)
    i=0
    for ITEM in ${VALUES}
    do
       if [ "$ITEM" == "NULL" ] ; then
          return
       fi
       ITEM_ARRAY["$i"]=$ITEM
       let i++
    done

    # delete
    SQL="delete from t_building_level_stat where building_id='${BUILDING_ID}';"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`    


    SQL="insert into t_building_level_stat(building_id, building_name, running_time, human_time, window_time, door_time) value('${BUILDING_ID}', '', ${ITEM_ARRAY[0]}, ${ITEM_ARRAY[1]}, ${ITEM_ARRAY[2]}, ${ITEM_ARRAY[3]})"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    echo "[$TIMESTAMP][UPDATE][SQL:$SQL]" >> ${LOG}     
}

function buildings_stat_level0() {
    DATE_PARAM=$1
    SQL="select building_id from t_building where building_level = 0;"

    MYSQL="mysql -h $HOST -P $PORT -D $DATABASE -u $USER -p$PASSWORD --default-character-set=utf8 -A -N"

    VALUES=`$MYSQL -e "$SQL" --skip-column-names`

    if [ "$VALUES" == "" ] ; then
       echo "[$TIMESTAMP][WARNNING][Has no building to stat]" >> $LOG
       return
    fi

    for ITEM in ${VALUES}
    do
        `building_item_stat_level0 ${ITEM} ${DATE_PARAM}`
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
    depts_stat ${START_TIMESTAMP}
    buildings_stat ${START_TIMESTAMP}

    buildings_stat_level0 ${START_TIMESTAMP}

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
        depts_stat ${START_TIMESTAMP}
        buildings_stat ${START_TIMESTAMP}

        buildings_stat_level0 ${START_TIMESTAMP}
    done
    exit
fi

# select sum(running_time) as running_time, sum(human_time) as human_time, sum(window_time) as window_time, sum(door_time) as door_time, avg(consumption) as avg, sum(total_consumption) as total_consumption, avg(humidity) as humidity, avg(temp) as temp, avg(hour_consumption) as hour_consumption from v_terminal_status_stat where dept_id='D36024639F2604B59CB5FD1D1FBE4712C' and stat_time=1513612800 \G;
# select sum(running_time) as running_time, sum(human_time) as human_time, sum(window_time) as window_time, sum(door_time) as door_time, avg(consumption) as avg, sum(total_consumption) as total_consumption, avg(humidity) as humidity, avg(temp) as temp, avg(hour_consumption) as hour_consumption from v_terminal_status_stat where building_id='B90F21966E51A47D2C75B71E31F6B4CD1' and stat_time=1513612800 \G;


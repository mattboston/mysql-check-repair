#!/bin/bash
# Copyright 2006 Matthew Shields matt@mattshields.org

MYSQL="mysql -S /var/lib/mysql/mysql.sock"

LOG=/var/log/mysql-check-tables.log

for db in `$MYSQL -B -N -e "show databases" | grep -v Database | grep -v "lost+found"`
do
    for table in `$MYSQL $db -B -N -e "show tables"`
    do
        echo "Checking $db.$table" >> $LOG
        $MYSQL $db -e "check table $table" | grep -v '\------' | grep -v "Msg_type" | grep -v "OK" >> $LOG
        $MYSQL $db -e "repair table $table" >> $LOG
    done
done

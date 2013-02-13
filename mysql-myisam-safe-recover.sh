#!/bin/bash
# Copyright 2006 Matthew Shields matt@mattshields.org

cd /var/lib/mysql/data
for D in `find ./ -type d | sed 's#\./##' | grep -v "^$"`
do
    cd $D
    echo
    echo
    echo
    echo "#############################################################"
    echo $D
    echo "#############################################################"
    for F in `find ./ -name "*.MYD" | sed 's#\./##' | sed 's/\.MYD//'`
    do
        echo "Table $F"
        myisamchk -f -F --safe-recover $F
    done
    cd ..
done

#!/bin/bash
for i in "$*"
do
    echo $i
    if [ "$i" = "3" ]
    then
        break
    fi
done

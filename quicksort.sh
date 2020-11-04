#!/bin/bash

arr=($@)

partition ()
{
    local p=${arr[$(($(($hi+$lo))/2))]}
    local i=$(($1-1))
    local j=$(($2+1))
    while true
    do
        i=$(($i+1))
        while [[ ${arr[$i]} -lt $p ]]
        do
            i=$(($i+1))
        done
        j=$(($j-1))
        while [[ ${arr[$j]} -gt $p ]]
        do
            j=$(($j-1))
        done
        if [[ $i -ge $j ]]
        then
            return $j
        fi
        local tmp=${arr[$j]}
        arr[$j]=${arr[$i]}
        arr[$i]=$tmp
    done
}

quicksort ()
{
    local lo=$1
    local hi=$2
    if [[ $lo -ge $hi ]]
    then
        return
    fi
    partition $lo $hi
    local p=$?
    quicksort $lo $p
    quicksort $(($p+1)) $hi
}

quicksort 0 ${#arr[*]}

echo ${arr[*]}

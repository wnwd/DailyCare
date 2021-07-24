#!/bin/bash

function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $1|head -1`;
    echo ${temp}|awk -F '|' '{print $2}';
}

json=`curl "http://api.tianapi.com/txapi/wanan/index?key=${{ secrets.TIAN_API_KEY }}"`

content=`jsonval content`

echo -n "$content" > night.txt

cat night.txt

#!/bin/bash

CUR_CITY=上海

function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w $1|head -1`;
    echo ${temp}|awk -F '|' '{print $2}';
}

json_tmp=`curl https://api.vvhan.com/api/weather?city=$CUR_CITY`

json=`echo $json_tmp | sed 's/高温 //g; s/低温 //g;'`

city=`jsonval city`
type=`jsonval type`
high=`jsonval high`
low=`jsonval low`
fengxiang=`jsonval fengxiang`
fengli=`jsonval fengli`
tip=`jsonval tip`

touch result.txt

printf "城市: $city\\\n" >> result.txt
printf "天气: $type\\\n" >> result.txt
printf "最高温度: $high\\\n" >> result.txt
printf "最低温度: $low\\\n" >> result.txt
printf "风向: $fengxiang\\\n" >> result.txt
printf "风力: $fengli\\\n" >> result.txt
printf "提示: $tip" >> result.txt

cat result.txt

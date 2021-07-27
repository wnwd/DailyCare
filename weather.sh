#!/bin/bash

CUR_CITY=上海

function jsonval {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/\[/ /g; s/\]/ /g; ' | sed 's/\"//g' | grep -w $1|head -1`;
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

echo -n "城市:%20%20$city" >> result.txt
echo -n "天气:%20%20$type" >> result.txt
echo -n "最高温度:%20%20$high" >> result.txt
echo -n "最低温度:%20%20$low" >> result.txt
echo -n "风向:%20%20$fengxiang" >> result.txt
echo -n "风力:%20%20$fengli" >> result.txt
echo -n "提示:%20%20$tip" >> result.txt

cat result.txt

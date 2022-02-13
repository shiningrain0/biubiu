#!/bin/bash
read -p "请输入日期(例:20201208): " s
#echo "数字长度为${#s}"
#判断输入是否为纯数字且为8位
if [[ "$s" =~ ^[0-9]+$ && ${#s} == 8 ]]
then
#截取年份
var1=${s:0:4}
#截取月份
var2=${s:4:2}
#截取天
var3=${s:6:2}
var1=$(($var1))
var2=$((10#$var2))
var3=$((10#$var3))
#输出年、月、日
echo "$var1年$var2月$var3日"
#判断该年份为闰年还是平年的表达式
val1=`expr $var1 % 4`
val2=`expr $var1 % 100`
val3=`expr $var1 % 400`
#判断年份与月份是否为正确日期
if [[ $var1 -eq 0 || $var2 -lt 1 || $var2 -gt 12 ]]
then
	echo "无效日期"
	exit;
else
#判断是闰年还是平年
if [[ $val1 == 0 && $val2 != 0 || $val3 == 0 ]]
then
	year=1
        echo "$var1是闰年"
else
	year=2
        echo "$var1是平年"
fi
#判断日期中的天是否为正确日期
case $var2 in
	1|3|5|7|8|10|12)
		if [[ $var3 -gt 31 || $var3 -eq 0 ]]
		then
			echo "请输入正确的日期"
			exit
		else
		echo "当月第一天日期为：`date -d "$var1-$var2-01" "+%Y-%m-%d"`"
		printf "当月最后一天为：%.4d-%.2d-%.2d \n" $var1 $var2 31
		fi
		;;
	4|6|9|11)
		if [[ $var3 -gt 30 || $var3 -eq 0 ]]
		then
			echo "请输入正确的日期"
			exit
		else
		printf "当月第一天为：%.4d-%.2d-%.2d \n" $var1 $var2 01
		printf "当月最后一天为：%.4d-%.2d-%.2d \n" $var1 $var2 30		
		fi
		;;
#当月份为2月时根据闰年和平年来计算当月信息
	2)
		if [[ $year -eq 1 ]]
		then
		if [[ $var3 -gt 29 || $var3 -eq 0 ]]
                then
                        echo "请输入正确的日期"
                        exit
                else
                        printf "当月第一天为：%.4d-%.2d-%.2d \n" $var1 $var2 01
                        printf "当月最后一天为：%.4d-%.2d-%.2d \n" $var1 $var2 29
		fi
		fi
		if [[ $year -eq 2 ]]
		then
			 if [[ $var3 -gt 28 || $var3 -eq 0 ]]
                then
                        echo "请输入正确的日期"
                        exit
                else
                        printf "当月第一天为：%.4d-%.2d-%.2d \n" $var1 $var2 01
                        printf "当月最后一天为：%.4d-%.2d-%.2d \n" $var1 $var2 28
                fi
				fi
				;;
esac
	#输出当天是星期几
	day=`date -d "$var1-$var2-$var3" +%A`
	echo "当天为星期： $day"
	#上上个月最后一天为上月第一天-1
	day2=`date -d "$(date -d "- 1 month $var1-$var2-01") - 1 day" "+%Y-%m-%d"`
	echo "上上个月最后一天为：$day2"
	#输出下周的日期
	day3=`date -d "+ 1 week $var1-$var2-$var3" +%A`
	#根据下周的日期计算下周周一的日期
	if [ $day3 == Monday ]
	then
		mon=`date -d "+ 1 week $var1-$var2-$var3" "+%Y-%m-%d"`
		echo "下周周一日期为：$mon"
	elif [[ $day3 == Tuesday ]]
	then
		mon=`date -d "$(date -d "+ 1 week $var1-$var2-$var3") - 1 day" "+%Y-%m-%d"`
                echo "下周周一的日期为：$mon"
	elif [[ $day3 == Wednesday ]]
        then
                mon=`date -d "$(date -d "+ 1 week $var1-$var2-$var3") - 2 day" "+%Y-%m-%d"`
                echo "下周周一的日期为：$mon"
	elif [[ $day3 == Thursday ]]
        then
                mon=`date -d "$(date -d "+ 1 week $var1-$var2-$var3") - 3 day" "+%Y-%m-%d"`
                echo "下周周一的日期为：$mon"
	elif [[ $day3 == Friday ]]
        then
                mon=`date -d "$(date -d "+ 1 week $var1-$var2-$var3") - 4 day" "+%Y-%m-%d"`
                echo "下周周一的日期为：$mon"
	elif [[ $day3 == Saturday ]]
        then
                mon=`date -d "$(date -d "+ 1 week $var1-$var2-$var3") - 5 day" "+%Y-%m-%d"`
                echo "下周周一的日期为：$mon"
	elif [[ $day3 == Sunday ]]
        then
                mon=`date -d "$(date -d "+ 1 week $var1-$var2-$var3") - 6 day" "+%Y-%m-%d"`
                echo "下周周一的日期为：$mon"
fi
fi
else
	echo "请输入八位数日期！！"
	exit
fi
#输出该月的日历
cal $var3 $var2 $var1
echo 按任意键继续
read -n 1
echo 继续运行

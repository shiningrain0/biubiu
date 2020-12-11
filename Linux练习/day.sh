#!/bin/bash
echo "输入的年份为:$1";
        cal -y $i
val1=`expr $1 % 4`
val2=`expr $1 % 100`
val3=`expr $1 % 400`
#判断是否为闰年
if [[ $val1 == 0 && $val2 != 0 || $val3 == 0 ]]
then
for i in $(seq 12);do
case $i in
1|3|5|7|8|10|12)
        for j in $(seq 31);do
        printf "%.4d%.2d%.2d\n" $1  $i $j
        done
        ;;
2)
        for j in $(seq 29);do
        printf "%.4d%.2d%.2d\n" $1  $i $j
        done
        ;;
4|6|9|11)
        for j in $(seq 30);do
        printf "%.4d%.2d%.2d\n" $1  $i $j
        done
        ;;
esac
done
else
for i in $(seq 12);do
case $i in
1|3|5|7|8|10|12)
        for j in $(seq 31);do
        printf "%.4d%.2d%.2d\n" $1  $i $j
        done
        ;;
2)
        for j in $(seq 28);do
        printf "%.4d%.2d%.2d\n" $1  $i $j
        done
        ;;
4|6|9|11)
        for j in $(seq 30);do
        printf "%.4d%.2d%.2d\n" $1  $i $j
        done
        ;;
esac
done
fi

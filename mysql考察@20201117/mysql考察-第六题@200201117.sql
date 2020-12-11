# 题目6、查询"李"姓老师的数量
use test;
/*
分析：
使用模糊查询查出“李”姓老师
使用count()函数统计“李”姓老师个数
*/
select
    count(t_name) teacher_li    /*"李"姓老师个数*/
from
     teacher                    /*教师表*/
where
      t_name
like '李%';
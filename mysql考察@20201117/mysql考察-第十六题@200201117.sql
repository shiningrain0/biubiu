# 题目16、检索"01"课程分数小于60，按分数降序排列的学生信息
use test;
/*
筛选出课程号为01 以及该课程分数小于60
根据课程分数进行降序排列
*/
select
    t.*                     /*01课程分数小于60的学生信息*/
from
    student t               /*学生表*/
inner join
    score t1                /*成绩表*/
on
    t.s_id = t1.s_id
where
    t1.c_id = 01 and t1.s_score < 60
order by
    t1.s_score desc;

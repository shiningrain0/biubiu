# 题目12、查询至少有一门课与学号为"01"的同学所学相同的同学的信息
use test;
/*
分析：
查询学号id为01的学生的课程id
将学号为01的学生课程id与其他学生的课程id进行匹配，若有一门匹配成功则输出其个人信息
*/
select
    t.*                     /*学生信息*/
from
    student t               /*学生表*/
left join
    score t1                /*成绩表*/
on
    t.s_id = t1.s_id
where
    t1.c_id
in (select c_id from score where s_id = 01 group by c_id) and t1.s_id != 01
group by
    s_id;


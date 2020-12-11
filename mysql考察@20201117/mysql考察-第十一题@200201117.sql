# 题目11、查询没有学全所有课程的同学的信息
use test;
/*
分析：
使用做左关联将学生表与成绩表进行关联
找出编号为"01","02","03"课程成绩任一一门课程为空的学生id
通过学生id查询出对应的学生信息
*/
select s_id,s_score from score where s_score >= 0 group by s_id;
select
     t.*                            /*学过编号为"01"并且也学过编号为"02"的课程的学生信息*/
from
    student t                       /*学生表*/
left join
    score t1                        /*成绩表*/
on
    t.s_id = t1.s_id and t1.c_id = 01
left join
    score t2                        /*成绩表*/
on
    t.s_id = t2.s_id and t2.c_id = 02
left join
    score t3                        /*成绩表*/
on
    t.s_id = t3.s_id and t3.c_id = 03
where
    t1.s_score is null or t2.s_score is null or t3.s_score is null
group by
    t.s_id;
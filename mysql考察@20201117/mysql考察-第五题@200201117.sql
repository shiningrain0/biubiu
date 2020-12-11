# 题目5、查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩
use test;
/*
分析：
通过学生编号将学生表与成绩表进行关联
使用count()函数计算选课数目
使用sum()函数计算课程总成绩
通过学生编号进行分组
 */
select
     t.s_id                              /*学生编号*/
    ,t.s_name                            /*学生姓名*/
    ,count(t1.c_id) score_nm             /*选课总数*/
    ,sum(t1.s_score) sum_score           /*所有课程总成绩*/
from
    student t           /*学生表*/
inner join
    score t1            /*成绩表*/
on
    t.s_id = t1.s_id
group by t.s_id;
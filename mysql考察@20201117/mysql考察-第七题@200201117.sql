# 题目7、查询学过"张三"老师授课的同学的信息
use test;
/*
分析：
学生表、老师表、授课表、成绩表
通过学生编号将学生表与成绩表进行关联
通过课程编号将成绩表与课程表进行关联
通过教师编号将课程表与教师表进行关联
使用where筛选授课老师名为张三的老师
*/
select
     t.s_id                 /*学生id*/
    ,t.s_name               /*学生姓名*/
    ,t.s_birth              /*学生生日*/
    ,t.s_sex                /*学生性别*/
from
    student t               /*学生表*/
inner join
    score t1                /*成绩表*/
on
    t.s_id = t1.s_id
inner join
    course t2               /*课程表*/
on
    t1.c_id = t2.c_id
inner join
    teacher t3              /*教师表*/
on
    t2.t_id = t3.t_id
where
    t3.t_name = '张三';

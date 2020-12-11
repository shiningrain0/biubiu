# 题目4、查询平均成绩小于60分的同学的学生编号和学生姓名和平均成绩（包括有成绩的和无成绩的）
use test;
/*
分析：
通过学生号将学生表与成绩表进行关联
使用学生id进行数据进行分组
如果平均成绩为空则设其值为0
使用having对平均成绩进行筛选
*/
select
     t.s_id                 /*学生编号*/
    ,t.s_name               /*学生姓名*/
    /*,avg(t1.s_score)*/         /*平均成绩*/
    ,if(avg(t1.s_score) is null,0,avg(t1.s_score)) as c
from
    student t               /*学生表*/
left join
    score t1                /*成绩表*/
on
    t.s_id = t1.s_id
group by
    t.s_id
having
    if(avg(t1.s_score) is null,0,avg(t1.s_score)) < 60 ;

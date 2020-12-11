use test;
# 题目15、查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
/*
分析：
使用学生id进行分组
筛选学生成绩小于六十且科目数量大于2的学生信息
*/
select
     t.s_id                     /*学生编号*/
    ,t.s_name                   /*学生姓名*/
    ,avg(t1.s_score)           /*平均成绩*/
    ,t1.s_score
from
    student t
left join
    score t1
on
    t.s_id = t1.s_id
group by
    t.s_id
having
    t1.s_score < 60  and count(t1.c_id) >= 2;




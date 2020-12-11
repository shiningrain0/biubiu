# 题目22、写一个过程，fixScore() 将每个s_id分数最高的科目对应的教师ID存入一张表中。表自定义，字段需要有s_id, s_name, t_name, c_name
use test;
/*
分析：
通过成绩表关联课程表、学生表，课程表关联教师表找出每个每个s_id分数最高所对应的教师id
*/
drop procedure fixScore;
create procedure fixScore()  /*创建存储过程名称*/
begin
    select
        t.s_id          /*学生id*/
       ,t2.s_name       /*学生姓名*/
       ,t3.t_name        /*老师姓名*/
       ,t3.t_id          /*老师id*/
       ,t1.c_name       /*课程名称*/
        ,max(t.s_score) max_score /*成绩*/
from
    score t             /*成绩表*/
left join
    course t1           /*课程表*/
on
    t.c_id = t1.c_id
right join
    student t2          /*学生表*/
on
    t.s_id = t2.s_id
left join
    teacher t3          /*教师表*/
on
    t1.t_id = t3.t_id
group by
    t.s_id;
end;
call fixScore;          /*调用存储过程*/


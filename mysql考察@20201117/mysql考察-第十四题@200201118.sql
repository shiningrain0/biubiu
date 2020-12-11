# 题目14、查询没学过"张三"老师讲授的任一门课程的学生姓名
/*
分析：
通过教师id找出张三所对应的课程
根据课程id找出没有修张三课程的学生id
*/
select
    t.s_name                    /*学生信息*/
from
    student t               /*学生表*/
left join
    score t1                /*成绩表*/
on
    t.s_id = t1.s_id
left join
    course t2               /*课程表*/
on
    t1.c_id = t2.c_id
left join
    teacher t3              /*教师表*/
on
    t2.t_id = t3.t_id
group by
    t.s_id
having
    t.s_id not in
    (select s_id from score  where c_id in
    (select c_id from course where t_id  not in
    (select t_id from teacher where t_name !='张三'))
    group by s_id);






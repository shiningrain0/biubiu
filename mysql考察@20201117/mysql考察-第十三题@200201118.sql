# 题目13、查询和"01"号的同学学习的课程完全相同的其他同学的信息
use test;
/*
分析：
通过学生id将学生表与成绩表进行关联
通过取反筛选出课程与01号学生科目相同的课程
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
      t.s_id
not in(select s_id from score where c_id
not in (select c_id from score where s_id=01))
and t.s_id != 01
group by
    t.s_id              /*学生id*/
having
    count(*) = (select count(*) from score where s_id = 01);

# 非正确写法（此写法仅统计课程数目与01号学生相同的学生信息）
select
     t.*                     /*学生信息*/
    ,t1.s_id
from
    student t               /*学生表*/
inner join
    score t1                /*成绩表*/
on
    t.s_id = t1.s_id
group by
    t.s_id                  /*学生学号*/
having
   count(t1.c_id) = (select count(score.c_id) from score where score.s_id = 01) and t1.s_id != 01;

# 题目20、查询学生的总成绩并进行排名
use test;
/*
使用学生编号对学生表已经成绩表进行关联
通过学生id进行分组并使用sum函数计算学生成绩使用降序排列
*/
select
     t.s_name               /*学生姓名*/
    ,sum(t1.s_score)        /*总成绩*/
from
    student t               /*学生表*/
inner join
    score t1                /*成绩表*/
on t.s_id = t1.s_id
group by
    t.s_id
order by
    sum(t1.s_score) desc;

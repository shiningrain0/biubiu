use test;
# 题目19、按各科成绩进行排序，并显示排名
/*
分析：
使用学生id将学生表与成绩表进行关联
首先根据可能id进行排序，再根据成绩进行降序排序
*/
# 此提仅根据课程id进行分组，但是在进行排序时是根据所有的成绩进行排序的
select
     t.*                    /*学生姓名*/
     ,t1.*
    ,row_number() over ( order by s_score  desc)
from
    student t               /*学生表*/
left join
    score t1                /*成绩表*/
on t.s_id = t1.s_id
left join
    score t2                /*成绩表*/
on t.s_id = t2.s_id
group by
    t.s_id,t1.c_id
 order by
    t1.c_id,t1.s_score desc;



